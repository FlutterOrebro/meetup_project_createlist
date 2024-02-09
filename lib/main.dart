import 'package:flutter/material.dart';

void main() => runApp(const ListApp());

class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Todolist(),
    );
  }
}

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final List<Todo> _todos = [
    Todo(name: 'Todo 1'),
    Todo(name: 'Todo 2'),
    Todo(name: 'Todo 3'),
  ];

  final TextEditingController _textEditingController = TextEditingController();

  void _addItem(String item) {
    setState(() {
      _todos.add(Todo(name: item));
    });
  }

  void _removeItem(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleChecked(int index) {
    setState(() {
      _todos[index].isChecked = !_todos[index].isChecked;
    });
  }

  Future<void> _displayAddItemDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'Enter todo here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _textEditingController.clear();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  _addItem(_textEditingController.text);
                  Navigator.of(context).pop();
                  _textEditingController.clear();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Application'),
        centerTitle: true,
        elevation: 4,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(index);
                      },
                    ),
                    title: Text(
                      _todos[index].name,
                      style: TextStyle(
                        decoration: _todos[index].isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 18,
                      ),
                    ),
                    leading: Checkbox(
                      value: _todos[index].isChecked,
                      onChanged: (value) {
                        _toggleChecked(index);
                      },
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container();
            },
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

class Todo {
  final String name;
  bool isChecked;

  Todo({required this.name, this.isChecked = false});
}
