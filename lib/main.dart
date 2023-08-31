import 'package:diceroll/model/dice.dart';
import 'package:diceroll/model/rolled_dice.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<Dice> diceList = <Dice>[
  Dice(number: 4),
  Dice(number: 6),
  Dice(number: 8),
  Dice(number: 10),
  Dice(number: 20)
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super D20 Roller',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Super D20 Roller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _minValue = 1;
  List<RolledDice> _rolledValues = [];

  Dice _selectedDice = diceList.first;

  final scrollController = ScrollController();

  callback(newDice) {
    setState(() => _selectedDice = newDice);
  }

  @override
  Widget build(BuildContext context) {
    // This method is r erun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(children: <Widget>[
              const Text(
                'Select dice:',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              DropdownButtonExample(callback: callback),
            ]),
            Column(children: [
              const Text(
                'Tap to roll:',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    shadowColor: Colors.pink,
                    elevation: 5,
                    surfaceTintColor: Colors.white),
                onPressed: () {
                  setState(() {
                    _rolledValues.insert(
                        0,
                        RolledDice(
                            dice: _selectedDice,
                            rolled: _selectedDice.rollValue));
                  });
                  scrollController.animateTo(
                      scrollController.position.minScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeOut);
                },
                child:
                    Image.network(_selectedDice.image, width: 300, height: 300),
              )
            ]),
            SizedBox(
                height: 100,
                child: _rolledValues.isEmpty
                    ? const Text('Rolled dice will be displayed here!')
                    : ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: _rolledValues.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              width: 140,
                              height: 120,
                              child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                          child: Row(children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.network(
                                                _rolledValues[index].dice.image,
                                                width: 40,
                                                height: 40,
                                              ),
                                              Text(_rolledValues[index]
                                                  .dice
                                                  .name),
                                            ]),
                                        Text(
                                          '${_rolledValues[index].rolled}',
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 48),
                                        ),
                                      ])))));
                        }))
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key, required this.callback});

  final Function(Dice) callback;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  Dice selectedDice = diceList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Dice>(
      itemHeight: 100,
      value: selectedDice,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (Dice? value) {
        // This is called when the user selects an item.
        setState(() {
          selectedDice = value ?? diceList.first;
          widget.callback(selectedDice);
        });
      },
      items: diceList.map<DropdownMenuItem<Dice>>((Dice newDice) {
        return DropdownMenuItem<Dice>(
            value: newDice,
            child: Center(
                child: Row(
              children: <Widget>[
                Image.network(newDice.image),
                Text(
                  newDice.name,
                  style: const TextStyle(fontSize: 32),
                ),
              ],
            )));
      }).toList(),
    );
  }
}
