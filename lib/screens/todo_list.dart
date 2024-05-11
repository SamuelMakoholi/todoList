import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/services/todo_service.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];
  

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    //delete item by Id
   final isSuccess = await TodoService.deleteById(id);
    if(isSuccess == 200){
      //remove from the list
      final filtered = items.where((element) => element['_id'] != id).toList();

      setState(() {
        items = filtered;
      });

    }else{
      //show error
      showErrorMessage("Deletion Failed");
    }

    //remove item from the list
  }

  Future<void> fetchTodo() async {

    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final result = json['items'] as List<dynamic>;

      setState(() {
        items = result;
      });
    } 

    setState(() {
      isLoading = false;
    });
  }

   void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.red,
        ),
      ),
    );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List Page'),
      ),
     body: RefreshIndicator(
  onRefresh: fetchTodo,
    child: Visibility(
      visible: isLoading,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      replacement: RefreshIndicator(
        onRefresh: fetchTodo,
        child: Visibility(
          visible: items.isNotEmpty,
          replacement: Center(
            child: Text(
              'No Todo Items',
              style: Theme.of(context).textTheme.headlineSmall,
              )),
        child: ListView.builder(

          itemCount: items.length,
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final item = items[index] as Map;
            final id = item['_id'] as String;
        
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) => {
                    if(value == 'edit'){
                      //open edit page
                      navigateToEditPage(item)
                      
                    } else if (value == 'delete') {
                      //delete and refresh page
                      deleteById(id)
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('Edit'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('Delete'),
                        value: 'delete',),
                    ];
                      
                }),
              ),
            );
          },
        ),
      ),
      )
    ),
  ),
     
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add todo list'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
      final route = MaterialPageRoute(
        builder: (context) => AddTodoPage(todo: item),
        );
     await Navigator.push(context, route);
      setState(() {
     isLoading = true;
   });
   fetchTodo();
      
    }

  Future <void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
   await Navigator.push(context, route);
   setState(() {
     isLoading = true;
   });
   fetchTodo();
  }
}

