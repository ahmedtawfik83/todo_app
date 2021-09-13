import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:todo_app/controllers/todoController.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends GetWidget {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        Database().addTodo(_todoController.text);
                        _todoController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Todos List",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (_, index) {
                      return TodoCard(todo: todoController.todos[index]);
                    },
                  ),
                );
              } else {
                return Text("loading...");
              }
            },
          )
        ],
      ),
    );
  }
}
