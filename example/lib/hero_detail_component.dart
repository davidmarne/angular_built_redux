import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';
import 'package:built_redux/built_redux.dart';
import 'package:angular_built_redux/angular_built_redux.dart';

import 'hero.dart';
import 'hero_service.dart';

@Component(
    selector: 'my-hero-detail',
    templateUrl: 'hero_detail_component.html',
    styleUrls: const ['hero_detail_component.css'])
class HeroDetailComponent extends AngularRedux<Heros, HerosBuilder, HerosActions> {
  ChangeDetectorRef _ref;

  final RouteParams _routeParams;
  final Location _location;

  HeroDetailComponent(HeroService herosService, this._routeParams, this._location, this._ref) {
    store = herosService.store;
  }

  ChangeDetectorRef get ref => _ref;

  @Redux
  Hero get hero => store.state.heros.elementAt(id);

  @override
  Store<Heros, HerosBuilder, HerosActions> store;

  int get id => int.parse(_routeParams.get('id'));

  void nameChange(String name) => store.actions.updateHeroName(new Hero(hero.id, name));

  void goBack() => _location.back();
}
