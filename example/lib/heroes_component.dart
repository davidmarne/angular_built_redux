import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular_built_redux/angular_built_redux.dart';
import 'package:built_redux/built_redux.dart';

import 'hero.dart';
import 'hero_service.dart';

@Component(
    selector: 'my-heroes',
    templateUrl: 'heroes_component.html',
    styleUrls: const ['heroes_component.css'])
class HeroesComponent extends AngularRedux<Heros, HerosBuilder, HerosActions> {
  final Router _router;
  ChangeDetectorRef _ref;

  Hero selectedHero;

  HeroesComponent(HeroService heroService, this._router, this._ref) {
    store = heroService.store;
  }

  ChangeDetectorRef get ref => _ref;

  @Redux
  Iterable<Hero> get heroes => store.state.heros;

  @override
  Store<Heros, HerosBuilder, HerosActions> store;

  void onSelect(Hero hero) {
    selectedHero = hero;
  }

  Future<Null> gotoDetail() => _router.navigate([
        'HeroDetail',
        {'id': selectedHero.id.toString()}
      ]);
}
