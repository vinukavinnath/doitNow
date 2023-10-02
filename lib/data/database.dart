import 'package:hive/hive.dart';

class Database {
  final _taskBox = Hive.box('taskBox');

  List tasks = [];

  void initialState() {
    tasks = [
      ['Task Category', 'Your Task will go here...'],
    ];
  }

  void loadTasks() {
    tasks = _taskBox.get('todolist');
  }

  void updateTasks() {
    _taskBox.put('todolist', tasks);
  }
}
