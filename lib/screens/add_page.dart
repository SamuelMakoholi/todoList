

import 'package:flutter/material.dart';

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
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Background color
            ),
            child: const Text('Submit'),
            )
        ],),
    );
  }

  void submitData() {
    //get the data from the form
    //submit data
  }
}