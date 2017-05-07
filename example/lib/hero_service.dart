library hero_service;

import 'package:angular2/core.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'hero.dart';
import 'mock_heroes.dart';

part 'hero_service.g.dart';

@Injectable()
class HeroService {
  Store<Heros, HerosBuilder, HerosActions> store;

  HeroService() {
    store = new Store<Heros, HerosBuilder, HerosActions>(
      new Heros((b) => b..nextId = 0),
      new HerosActions(),
      middleware: [],
    );
  }
}

abstract class HerosActions extends ReduxActions {
  ActionDispatcher<Null> fetchMoreHeros;
  ActionDispatcher<Hero> updateHeroName;

  HerosActions._();
  factory HerosActions() => new _$HerosActions();
}

_fetchMoreHeros(Heros state, Action<Null> action, HerosBuilder builder) => builder
  ..nextId = state.nextId + 10
  ..heros.addAll(generateHeros(state.nextId, 10));

_updateHeroName(Heros state, Action<Hero> action, HerosBuilder builder) =>
    builder..heros.setAll(action.payload.id, [action.payload]);

final _reducer = (new ReducerBuilder<Heros, HerosBuilder>()
      ..add<Null>(HerosActionsNames.fetchMoreHeros, _fetchMoreHeros)
      ..add<Hero>(HerosActionsNames.updateHeroName, _updateHeroName))
    .build();

// Built Reducer
abstract class Heros extends BuiltReducer<Heros, HerosBuilder>
    implements Built<Heros, HerosBuilder> {
  int get nextId;

  BuiltList<Hero> get heros;

  // The reducer
  get reducer => _reducer;

  // Built value boilerplate and default state
  Heros._();
  factory Heros([updates(HerosBuilder b)]) = _$Heros;
}
