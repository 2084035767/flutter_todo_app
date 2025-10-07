import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/stores/task_store.dart';

void main() {
  testWidgets('TaskScreen has title and empty state message', (tester) async {
    // 构建Widget树
    await tester.pumpWidget(const MyApp());

    // 验证标题存在
    expect(find.text('Todo List'), findsOneWidget);

    // 验证空状态消息存在
    expect(find.text('暂无任务\n点击右下角添加'), findsOneWidget);
  });

  testWidgets('Can add a task through dialog', (tester) async {
    await tester.pumpWidget(const MyApp());
    
    // 点击添加按钮
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // 验证对话框出现
    expect(find.text('添加新任务'), findsOneWidget);

    // 输入任务标题
    await tester.enterText(find.byType(TextField), '测试任务');

    // 点击添加按钮
    await tester.tap(find.text('添加'));
    await tester.pumpAndSettle();

    // 验证任务出现在列表中
    expect(find.text('测试任务'), findsOneWidget);
  });
}