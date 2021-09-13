import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(String content) async {
    //  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    try {
      _firestore.collection("data").doc("todo").collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<TodoModel>> todoStream() {
    // FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

    return _firestore
        .collection("data")
        .doc("todo")
        .collection("todos")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> val = [];
      query.docs.forEach((element) {
        val.add(TodoModel.fromDocumentSnapshot(element));
      });
      return val;
    });
  }

  Future<void> updateTodo(bool newValue, String todoId) async {
    //FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

    try {
      _firestore
          .collection("data")
          .doc("todo")
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
