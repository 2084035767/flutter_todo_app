import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:todo_app/models/task.dart';

class TaskStore {
  final tasks = Signal<List<Task>>([]);
  final categories = Signal<List<String>>(['全部', '工作', '个人', '购物']);
  final currentCategoryIndex = Signal<int>(0);
  late final filteredTasks = computed<List<Task>>(() {
    final cat = categories.value[currentCategoryIndex.value];
    return cat == '全部'
        ? List.from(tasks.value)
        : tasks.value.where((t) => t.category == cat).toList();
  });

  TaskStore() {
    _loadTasks();
  }

  setCategory(int index) {
    currentCategoryIndex.set(index);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = prefs.getStringList('tasks') ?? [];
    final loadedTasks = taskStrings
        .map((s) => Task.fromJson(jsonDecode(s)))
        .toList();
    tasks.set(loadedTasks);
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = tasks.value.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  Future<void> addTask(Task task) async {
    tasks.set([...tasks.value, task]);
    await _saveTasks();
  }

  Future<void> toggleTask(int index) async {
    if (index < 0 || index >= tasks.value.length) return;
    final newList = List<Task>.from(tasks.value);
    newList[index] = newList[index].copyWith(isDone: !newList[index].isDone);
    tasks.set(newList);
    await _saveTasks();
  }

  Future<void> deleteTask(int index) async {
    if (index < 0 || index >= tasks.value.length) return;
    tasks.set(tasks.value..removeAt(index));
    await _saveTasks();
  }
}
