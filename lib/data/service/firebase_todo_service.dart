// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../model/todo.dart';

// class FirebaseTodoService {
//   final _db = FirebaseFirestore.instance;

//   Future<void> uploadTodo(String userId, Todo todo) async {
//     await _db
//         .collection('users')
//         .doc(userId)
//         .collection('todos')
//         .doc(todo.id)
//         .set(todo.toJson());
//   }

//   Future<List<Todo>> fetchTodos(String userId) async {
//     final snapshot = await _db
//         .collection('users')
//         .doc(userId)
//         .collection('todos')
//         .get();

//     return snapshot.docs
//         .map((doc) => Todo.fromJson(doc.data()))
//         .toList();
//   }
// }
