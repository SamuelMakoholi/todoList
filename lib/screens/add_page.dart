

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
    });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    
    super.initState();
    final todo = widget.todo;

    if(todo != null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];

      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit ToDo' : 'Add ToDo',
        ),
      ),

      body:  ListView(
        padding: EdgeInsets.all(20),
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
            onPressed: isEdit ? updateData : submitData,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
            )
        ],),
    );
  }

    void showSuccessMessage(String message) {

          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

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

 Future<void> updateData() async {
  //update the item

  final todo = widget.todo;
  if(todo == null){
    print("You can not call updated without todo data");
    return;
  }
  final id = todo['_id'];
  final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    //submit data

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

     //Submit updated data
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri, 
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json'
      },
      );

         //show the succes or fail message on status
    if(response.statusCode ==200) {
      
      showSuccessMessage('Updated Successfully');

      }else {
      showErrorMessage('Updated Failed');
      }
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
    final response = await http.post(
      uri, 
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json'
      },
      );

    //show the succes or fail message on status
    if(response.statusCode ==201) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Creation Success');

    }else {
     showErrorMessage('Creation Failed');
    }

  }
}