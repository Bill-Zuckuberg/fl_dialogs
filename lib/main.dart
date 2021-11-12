import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dialogs Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Dialogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ElevatedButton _createButton(Color color, String str, void Function() fuc) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color.withOpacity(0.5);
              }
              return color;
            },
          ),
        ),
        onPressed: fuc,
        child: Text(
          str + '',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    void Function() _showAlert() {
      return () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Dialog Title'),
                content: const Text('Sample alert'),
                actions: [
                  TextButton(
                      onPressed: () {
                        return Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () => Navigator.pop(context, 'Ok'),
                      child: const Text('Ok'))
                ],
              )).then((returnVal) => {
            if (returnVal != null)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('You clicked: $returnVal'),
                      action: SnackBarAction(label: 'Back', onPressed: () {})),
                )
              }
          });
    }

    void Function() _showSimpleDialog() {
      return () => showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    title: const Text('Dialog Title'),
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('user1@example.com'),
                        onTap: () =>
                            Navigator.pop(context, 'user1@example.com'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('user2@example.com'),
                        onTap: () =>
                            Navigator.pop(context, 'user2@example.com'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: const Text('Add account'),
                        onTap: () => Navigator.pop(context, 'Add account'),
                      ),
                    ],
                  )).then((returnVal) {
            if (returnVal != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('You click: $returnVal'),
                action: SnackBarAction(
                  label: 'Back',
                  onPressed: () {},
                ),
              ));
            }
          });
    }

    void Function() _showTimePicker() {
      final DateTime now = DateTime.now();
      return () => showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('You chosee ' + value!.format(context)),
              action: SnackBarAction(
                label: 'Back',
                onPressed: () {},
              ),
            ));
          });
    }

    void Function() _showDatePicker() {
      return () => showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2025))
              .then((returnVal) {
            if (returnVal != null) {
              DateTime _fromDate = DateTime.now();
              _fromDate = returnVal;
              final String date = DateFormat.yMMMd().format(_fromDate);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'You selected date: $date',
                ),
                action: SnackBarAction(
                  label: 'Back',
                  onPressed: () {},
                ),
              ));
            }
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _createButton(Colors.red, 'Alert Dialog', _showAlert()),
            _createButton(Colors.yellow, 'Simple Dialog', _showSimpleDialog()),
            _createButton(
                Colors.green, 'Time Picker Dialog', _showTimePicker()),
            _createButton(Colors.blue, 'Date Picker Dialog', _showDatePicker()),
            _createButton(
                Colors.purple, 'Date Range Pick Dialog', _showSimpleDialog()),
            _createButton(Colors.orange, 'Bottom Sheet', _showSimpleDialog()),
          ],
        ));
  }
}
