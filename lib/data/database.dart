import 'package:hive/hive.dart';

class ToDoDataBase {
  List todo_list = [];

  void createInitialData() {
    todo_list = [
      ["Hello! this is a to-do app.", false],
    ];
  }

  void loadData() {
    todo_list = _todobox.get("TODOLIST");
  }

  void updateDatabase() {
    _todobox.put("TODOLIST", todo_list);
  }

  final _todobox = Hive.box('to-do-box');
}
