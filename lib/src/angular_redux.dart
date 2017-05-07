import 'dart:async';
import 'package:angular2/core.dart';
import 'package:built_redux/built_redux.dart';
import 'package:meta/meta.dart';
import 'package:built_value/built_value.dart';

const String Redux = 'Redux';

/// By having your component extend [AngularRedux], your component will only preform change detection
/// when your redux store triggers. If your component is driven by values outside of redux do not
/// extend [AngularRedux].
abstract class AngularRedux<State extends BuiltReducer<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions> {
  Store<State, StateBuilder, Actions> get store;
  ChangeDetectorRef get ref;
  StreamSubscription<StoreChange<State, StateBuilder, Actions>> _sub;

  @mustCallSuper
  Future<Null> ngOnInit() async {
    _sub = store.subscribe.listen(handleStoreChange);
    ref.detach();
  }

  @mustCallSuper
  Future<Null> ngOnDestroy() async {
    _sub.cancel();
  }

  void handleStoreChange(store) {
    throw new Exception(
        'handleStoreChange should be generated. Make sure the angular_built_redux transformer is included in your pubspec.yaml.');
  }
}
