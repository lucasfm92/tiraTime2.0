class Player {
  final String name;
  final int receiving;
  final int serving;
  final int attacking;
  final int blocking;
  final int lifting;
  int team;

  double get averageAttribute =>
      (receiving + serving + attacking + blocking + lifting) / 5;

  Player({
    required this.name,
    required this.receiving,
    required this.serving,
    required this.attacking,
    required this.blocking,
    required this.lifting,
    required this.team,
  });
}