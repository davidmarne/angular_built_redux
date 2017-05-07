import 'hero.dart';

Iterable<Hero> generateHeros(int nextId, int numToGen) {
  var newHeros = new List<Hero>();
  for (int i = 0; i < numToGen; i++) newHeros.add(new Hero(nextId + i, 'hero-${i + nextId}'));
  return newHeros;
}
