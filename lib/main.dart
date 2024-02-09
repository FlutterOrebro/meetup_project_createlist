import 'package:flutter/material.dart';

void main() => runApp(const ListApp());

class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo Application',
      home: Todolist(title: 'Todo Application'),
    );
  }
}

class Todolist extends StatefulWidget {
  const Todolist({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final List<String> _items = ['Todo 1', 'Todo 2', 'Todo 3'];
  final List<bool> _checked = [false, false, false];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
      _checked.add(false);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      _checked.removeAt(index);
    });
  }

  void _toggleChecked(int index) {
    setState(() {
      _checked[index] = !_checked[index];
    });
  }

  Future<void> _displayAddItemDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a new todo'),
            content: TextField(
              onSubmitted: (value) {
                _addItem(value);
                Navigator.of(context).pop();
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _removeItem(index);
              },
            ),
            title: Text(
              _items[index],
              style: TextStyle(
                decoration: _checked[index]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: _checked[index],
              onChanged: (bool? value) {
                _toggleChecked(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayAddItemDialog(context);
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
