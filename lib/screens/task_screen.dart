import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import '../stores/task_store.dart';
import '../widgets/add_task_dialog.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  final store = TaskStore();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: store.categories.value.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          onTap: store.setCategory,
          tabs: store.categories.value.map((e) => Tab(text: e)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => AddTaskDialog(onAdd: store.addTask),
        ),
        child: const Icon(Icons.add),
      ),
      body: Watch((_) {
        final list = store.filteredTasks.value;
        return list.isEmpty
            ? Center(
                child: Text(
                  store.currentCategoryIndex.value == 0
                      ? '暂无任务\n点击右下角添加'
                      : '该分类暂无任务',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final task = list[i];
                  final realIdx = store.tasks.value.indexOf(task);
                  return Dismissible(
                    key: ValueKey(task),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => store.deleteTask(realIdx),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        task.category,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        // 导航到任务详情页面
                        Navigator.pushNamed(context, '/task-detail', arguments: task);
                      },
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (_) => store.toggleTask(realIdx),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}