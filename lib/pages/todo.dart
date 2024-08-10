import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/utils/dialogue_box.dart';
import 'package:to_do/utils/todo_tile.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _todobox = Hive.box('to-do-box');
  final _controller = TextEditingController();

  ToDoDataBase database = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState
    if (_todobox.get("TODOLIST") == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      database.todo_list[index][1] = !database.todo_list[index][1];
    });
    database.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      database.todo_list.add([
        _controller.text,
        false,
      ]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    database.updateDatabase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogueBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      database.todo_list.removeAt(index);
    });
    database.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        title: const Text(
          "To-Do App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.blue[200],
      body: ListView.builder(
        itemCount: database.todo_list.length,
        itemBuilder: (context, index) {
          return TodoTile(
              taskName: database.todo_list[index][0],
              taskCompleted: database.todo_list[index][1],
              deleteTask: (context) => deleteTask(index),
              onChanged: (value) => checkBoxChanged(value, index));
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.blue[700],
        backgroundColor: Colors.blue[400],
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
