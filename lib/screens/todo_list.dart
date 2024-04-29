import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override

  List items = [];

  void initState() {
    super.initState();
    fetchTod();
  }



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


Future<void> fetchTod() async{
  final url ='https://api.nstack.in/v1/todos?page=1&limit=10';
  final uri = Uri.parse(url);
  final response =  await http.get(uri);

  if(response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List;

    // setState(() {
    //   items = result;
    // });
  } else {
    //show error message

  }

}