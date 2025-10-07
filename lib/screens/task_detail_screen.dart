import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '任务详情',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('标题'),
                      subtitle: Text(task.title),
                      tileColor: Colors.grey[50],
                    ),
                    ListTile(
                      title: Text('分类'),
                      subtitle: Text(task.category),
                      tileColor: Colors.grey[50],
                    ),
                    ListTile(
                      title: Text('状态'),
                      subtitle: Text(task.isDone ? '已完成' : '未完成'),
                      tileColor: Colors.grey[50],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}