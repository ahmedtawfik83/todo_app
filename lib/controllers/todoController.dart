import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoController extends GetxController {
  RxList<TodoModel> todoList = RxList<TodoModel>();

  List<TodoModel> get todos => todoList.value;

  @override
  void onInit() {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

    todoList.bindStream(Database().todoStream()); //stream coming from firebase
  }
}
