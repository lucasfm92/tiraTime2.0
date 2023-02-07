import 'package:flutter/material.dart';
import 'package:testegpt/models/player_model.dart';
//import 'package:firebase_database/firebase_database.dart';

//class Player {
//  final String name;
//  final int receiving;
//  final int serving;
//  final int attacking;
//  final int blocking;
//  final int lifting;
//  int team;
//
//  double get averageAttribute =>
//      (receiving + serving + attacking + blocking + lifting) / 5;
//
//  Player({
//    required this.name,
//    required this.receiving,
//    required this.serving,
//    required this.attacking,
//    required this.blocking,
//    required this.lifting,
//    required this.team,
//  });
//}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sort Teams',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(
        player: Player(
            attacking: 1,
            blocking: 1,
            lifting: 1,
            name: '',
            receiving: 1,
            serving: 1,
            team: 1),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final Player? player = null;
  HomePage({Key? key, Player? player}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Player? player = null;
  //final databaseReference = FirebaseDatabase.instance.reference();
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

  //void addPlayer(Player player) {
  //  setState(() {
  //    players.add(player);
  //    databaseReference.child("players").push().set({
  //      'name': player.name,
  //      'receiving': player.receiving,
  //      'serving': player.serving,
  //      'attacking': player.attacking,
  //      'blocking': player.blocking,
  //      'lifting': player.lifting,
  //      'team': player.team,
  //      'averageAttribute': player.averageAttribute,
  //    });
  //  });
  //}

  //void getData() {
  //  databaseReference.child("players").onValue.listen((Event event) {
  //    Map<dynamic, dynamic> values = event.snapshot.value;
  //    setState(() {
  //      players.clear();
  //      values.forEach((key, value) {
  //        players.add(Player(
  //          name: value['name'],
  //          receiving: value['receiving'],
  //          serving: value['serving'],
  //          attacking: value['attacking'],
  //          blocking: value['blocking'],
  //          lifting: value['lifting'],
  //          team: value['team'],
  //        ));
  //      });
  //    });
  //  });
  //}

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

  void deletePlayer(int index) {
    setState(() {
      teams[players[index].team].remove(players[index]);
      players.removeAt(index);
    });
  }

  void sortTeams() {
    setState(() {
      players.sort((a, b) => b.averageAttribute.compareTo(a.averageAttribute));
      for (var i = 0; i < players.length; i++) {
        players[i].team = i % 3;
        teams[players[i].team].add(players[i]);
        print(team);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double team1AttributeSum = 0;
    double team2AttributeSum = 0;
    double team3AttributeSum = 0;

    teams[0].forEach((player) {
      team1AttributeSum += player.averageAttribute;
    });

    teams[1].forEach((player) {
      team2AttributeSum += player.averageAttribute;
    });

    teams[2].forEach((player) {
      team3AttributeSum += player.averageAttribute;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tira Time 2.0'),
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deletePlayer(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: sortTeams,
            child: const Text('Sort Teams'),
          ),
          Text('Média do time 1: $team1AttributeSum'),
          Text('Média do time 2: $team2AttributeSum'),
          Text('Média do time 3: $team3AttributeSum'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddPlayerDialog(context);
          print(
              ' reciving: $receiving + serving: $serving + Attacking: $attacking + Blocking: $blocking + Lifting: $lifting');
        },
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
                onChanged: (value) {
                  int parsedValue = int.tryParse(value) ?? 1;
                  receiving = parsedValue.clamp(1, 5);
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Serving'),
                onChanged: (value) {
                  int parsedValue = int.tryParse(value) ?? 1;
                  serving = parsedValue.clamp(1, 5);
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Attacking'),
                onChanged: (value) {
                  int parsedValue = int.tryParse(value) ?? 1;
                  attacking = parsedValue.clamp(1, 5);
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Blocking'),
                onChanged: (value) {
                  int parsedValue = int.tryParse(value) ?? 1;
                  blocking = parsedValue.clamp(1, 5);
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Lifting'),
                onChanged: (value) {
                  int parsedValue = int.tryParse(value) ?? 1;
                  lifting = parsedValue.clamp(1, 5);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                addPlayer(
                  Player(
                    name: name,
                    receiving: receiving,
                    serving: serving,
                    attacking: attacking,
                    blocking: blocking,
                    lifting: lifting,
                    team: 0,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
