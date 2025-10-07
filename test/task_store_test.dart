import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/stores/task_store.dart';

void main() {
  group('TaskStore', () {
    late TaskStore store;

    setUp(() {
      store = TaskStore();
    });

    test('initial tasks list is empty', () {
      expect(store.tasks.value, isEmpty);
    });

    test('can add a task', () async {
      final task = Task(
        title: 'Test Task',
        isDone: false,
        category: '个人',
      );

      await store.addTask(task);

      expect(store.tasks.value, isNotEmpty);
      expect(store.tasks.value.length, 1);
      expect(store.tasks.value[0].title, 'Test Task');
    });

    test('can toggle task completion status', () async {
      final task = Task(
        title: 'Test Task',
        isDone: false,
        category: '个人',
      );

      await store.addTask(task);
      await store.toggleTask(0);

      expect(store.tasks.value[0].isDone, isTrue);
    });

    test('can delete a task', () async {
      final task = Task(
        title: 'Test Task',
        isDone: false,
        category: '个人',
      );

      await store.addTask(task);
      expect(store.tasks.value.length, 1);

      await store.deleteTask(0);
      expect(store.tasks.value, isEmpty);
    });
  });
}