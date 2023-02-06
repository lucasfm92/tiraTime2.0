import 'package:flutter/material.dart';

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sort Teams',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  int receiving = 1;
  int serving = 1;
  int attacking = 1;
  int blocking = 1;
  int lifting = 1;
  int team = 0;

  List<Player> players = [];
  List<List<Player>> teams = List.generate(3, (_) => []);

  void addPlayer(Player player) {
    setState(() {
      players.add(player);
    });
  }

  // divide os times com 5 jogadores no maximo por time
  //void sortTeams() {
  //  setState(() {
  //    players.sort((a, b) => b.averageAttribute.compareTo(a.averageAttribute));
  //    int teamIndex = 0;
  //    for (var i = 0; i < players.length; i++) {
  //      if (teams[teamIndex].length >= 5) {
  //        teamIndex++;
  //      }
  //      teams[teamIndex].add(players[i]);
  //    }
  //  });
  //}

  void sortTeams() {
    setState(() {
      players.sort((a, b) => b.averageAttribute.compareTo(a.averageAttribute));
      for (var i = 0; i < players.length; i++) {
        players[i].team = i % 3;
        teams[players[i].team].add(players[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort Teams'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(
                      '${players[index].name} - Team ${players[index].team + 1}'),
                  subtitle: Text('${players[index].averageAttribute}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: sortTeams,
            child: const Text('Sort Teams'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddPlayerDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddPlayerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Player'),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Receiving'),
                  onChanged: (value) => receiving = int.tryParse(value) ?? 1,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Serving'),
                  onChanged: (value) => serving = int.tryParse(value) ?? 1,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Attacking'),
                  onChanged: (value) => attacking = int.tryParse(value) ?? 1,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Blocking'),
                  onChanged: (value) => blocking = int.tryParse(value) ?? 1,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Lifting'),
                  onChanged: (value) => lifting = int.tryParse(value) ?? 1,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  addPlayer(Player(
                    name: name,
                    receiving: receiving,
                    serving: serving,
                    attacking: attacking,
                    blocking: blocking,
                    lifting: lifting,
                    team: team,
                  ));
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }
}
