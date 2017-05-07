import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:built_redux/built_redux.dart';
import 'package:angular_built_redux/angular_built_redux.dart';
import 'hero.dart';
import 'hero_service.dart';

@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: const ['dashboard_component.css'],
  directives: const [ROUTER_DIRECTIVES],
)
class DashboardComponent extends AngularRedux<Heros, HerosBuilder, HerosActions>
    implements OnInit, OnDestroy {
  ChangeDetectorRef _ref;

  DashboardComponent(this._ref, HeroService herosService) {
    store = herosService.store;
  }

  ChangeDetectorRef get ref => _ref;

  @Redux
  Iterable<Hero> get heroes => store.state.heros;

  @override
  Store<Heros, HerosBuilder, HerosActions> store;

  void fetchMoreHeros() => store.actions.fetchMoreHeros(null);
}
