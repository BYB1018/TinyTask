import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiny_task/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  
  List<Task> get allTasks => _taskBox.values.toList();
  List<Task> get completedTasks => allTasks.where((task) => task.isCompleted).toList();
  List<Task> get incompleteTasks => allTasks.where((task) => !task.isCompleted).toList();

  Future<void> addTask(String title) async {
    final task = Task(
      id: DateTime.now().toString(),
      title: title,
    );
    await _taskBox.put(task.id, task);
    notifyListeners();
  }

  Future<void> toggleTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
    notifyListeners();
  }

  Future<void> updateTask(Task task, String newTitle) async {
    task.title = newTitle;
    await task.save();
    notifyListeners();
  }
} 