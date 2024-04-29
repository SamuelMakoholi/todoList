import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List Page'),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage, label: const Text('Add todo list')),
    );
  }


  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
      );
      Navigator.push(context, route);
  }
}