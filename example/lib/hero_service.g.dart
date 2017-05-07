// GENERATED CODE - DO NOT MODIFY BY HAND

part of hero_service;

// **************************************************************************
// Generator: BuiltReduxGenerator
// Target: abstract class HerosActions
// **************************************************************************

class _$HerosActions extends HerosActions {
  ActionDispatcher<Hero> updateHeroName =
      new ActionDispatcher<Hero>('HerosActions-updateHeroName');

  ActionDispatcher<Null> fetchMoreHeros =
      new ActionDispatcher<Null>('HerosActions-fetchMoreHeros');
  factory _$HerosActions() => new _$HerosActions._();
  _$HerosActions._() : super._();
  syncWithStore(dispatcher) {
    updateHeroName.syncWithStore(dispatcher);
    fetchMoreHeros.syncWithStore(dispatcher);
  }
}

class HerosActionsNames {
  static ActionName updateHeroName =
      new ActionName<Hero>('HerosActions-updateHeroName');
  static ActionName fetchMoreHeros =
      new ActionName<Null>('HerosActions-fetchMoreHeros');
}

// **************************************************************************
// Generator: BuiltValueGenerator
// Target: abstract class Heros
// **************************************************************************

class _$Heros extends Heros {
  @override
  final int nextId;
  @override
  final BuiltList<Hero> heros;

  factory _$Heros([void updates(HerosBuilder b)]) =>
      (new HerosBuilder()..update(updates)).build();

  _$Heros._({this.nextId, this.heros}) : super._() {
    if (nextId == null) throw new ArgumentError.notNull('nextId');
    if (heros == null) throw new ArgumentError.notNull('heros');
  }

  @override
  Heros rebuild(void updates(HerosBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  HerosBuilder toBuilder() => new HerosBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Heros) return false;
    return nextId == other.nextId && heros == other.heros;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, nextId.hashCode), heros.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Heros')
          ..add('nextId', nextId)
          ..add('heros', heros))
        .toString();
  }
}

class HerosBuilder implements Builder<Heros, HerosBuilder> {
  _$Heros _$v;

  int _nextId;
  int get nextId => _$this._nextId;
  set nextId(int nextId) => _$this._nextId = nextId;

  ListBuilder<Hero> _heros;
  ListBuilder<Hero> get heros => _$this._heros ??= new ListBuilder<Hero>();
  set heros(ListBuilder<Hero> heros) => _$this._heros = heros;

  HerosBuilder();

  HerosBuilder get _$this {
    if (_$v != null) {
      _nextId = _$v.nextId;
      _heros = _$v.heros?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Heros other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Heros;
  }

  @override
  void update(void updates(HerosBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Heros build() {
    final result = _$v ?? new _$Heros._(nextId: nextId, heros: heros?.build());
    replace(result);
    return result;
  }
}
