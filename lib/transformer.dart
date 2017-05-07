import 'package:barback/barback.dart';
import 'package:analyzer/analyzer.dart';
import 'package:path/path.dart' as p;
import 'package:source_span/source_span.dart';
import 'package:transformer_utils/transformer_utils.dart';
import 'dart:async';
import 'dart:io';

class BuiltStoreTransformer extends Transformer {
  final BarbackSettings _settings;
  BuiltStoreTransformer.asPlugin(this._settings);

  @override
  String get allowedExtensions => ".dart";

  /// Converts [id] to a "package:" URI.
  ///
  /// This will return a schemeless URI if [id] doesn't represent a library in
  /// `lib/`.
  static Uri idToPackageUri(AssetId id) {
    if (!id.path.startsWith('lib/')) {
      return new Uri(path: id.path);
    }

    return new Uri(
        scheme: 'package', path: p.url.join(id.package, id.path.replaceFirst('lib/', '')));
  }

  @override
  Future apply(Transform transform) async {
    var primaryInputContents = await transform.primaryInput.readAsString();

    SourceFile sourceFile = new SourceFile(
      primaryInputContents,
      url: idToPackageUri(transform.primaryInput.id),
    );

    TransformedSourceFile transformedFile = new TransformedSourceFile(sourceFile);

    // Do not try to transform the source if it doesn't import built_redux
    if (!importsBuiltReducer(primaryInputContents)) return;

    // Parse the source file on its own and use the resultant AST to...
    var unit = parseCompilationUnit(
      primaryInputContents,
      suppressErrors: true,
      name: transform.primaryInput.id.path,
      parseFunctionBodies: true,
    );

    for (CompilationUnitMember d in unit.declarations) {
      if (d is! ClassDeclaration) continue;
      var cd = d as ClassDeclaration;
      var superclass = cd.extendsClause?.superclass;
      if (superclass == null) continue;
      if (superclass.name.name == 'AngularRedux') {
        String reduceChildrenBody =
            "\n\n  @override\n  handleStoreChange(storeChange) {\n    bool _shouldUpdate = false;\n}";

        for (ClassMember m in cd.members) {
          if (m is! MethodDeclaration) continue;
          var md = m as MethodDeclaration;
          if (!md.isGetter || !md.metadata.any((m) => m.name.name == 'Redux')) continue;
          var accessor = md.body.toSource();
          var prevAccessor = accessor.replaceFirst('=> store.state', 'storeChange.prev');
          var nextAccessor = accessor.replaceFirst('=> store.state', 'storeChange.next');
          prevAccessor = prevAccessor.replaceFirst(';', '');
          nextAccessor = nextAccessor.replaceFirst(';', '');

          reduceChildrenBody = reduceChildrenBody.replaceFirst(
              "}", "\n    _shouldUpdate = _shouldUpdate || $prevAccessor != $nextAccessor;\n}");
        }

        reduceChildrenBody = reduceChildrenBody.replaceFirst("}",
            'print(_shouldUpdate);\n    if (_shouldUpdate) {\n    ref.reattach();\n    ref.detectChanges();\n    ref.detach();}\n  }');

        transformedFile.insert(
            transformedFile.sourceFile.location(cd.members.endToken.end), reduceChildrenBody);
      }
    }

    if (transformedFile.isModified) {
      // Output the transformed source.
      transform.addOutput(
          new Asset.fromString(transform.primaryInput.id, transformedFile.getTransformedText()));
    } else {
      // Output the unmodified input.
      transform.addOutput(transform.primaryInput);
    }
  }
}

bool importsBuiltReducer(String source) => source.contains("package:built_redux");
