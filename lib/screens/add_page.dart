

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
      ),

      body:  ListView(
        padding: const EdgeInsets.all(20),
        children: [
        TextField(
          controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          
         const SizedBox(height: 20.0,),

         TextField(
          controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),

         SizedBox(height: 20.0),

          ElevatedButton(
            onPressed: submitData,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Background color
            ),
            child: const Text('Submit'),
            )
        ],),
    );
  }

  Future<void> submitData()  async {
    //get the data from the form

    final title = titleController.text;
    final description = descriptionController.text;
    //submit data

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    //Submit data to the surver
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body));

    //show the succes or fail message on status
    print(response);

  }
}