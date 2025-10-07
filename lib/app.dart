import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/screens/task_detail_screen.dart';
import 'package:todo_app/screens/task_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TODO",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskScreen(),
      // 不传参写法
      // routes: {'/task-detail': (context) => const Placeholder()},
      // 传参写法
      onGenerateRoute: (settings) {
        if (settings.name == '/task-detail') {
          final Task task = settings.arguments as Task;
          return MaterialPageRoute(
            builder: (context) => TaskDetailScreen(task: task),
          );
        }
        return null;
      },
    );
  }
}
