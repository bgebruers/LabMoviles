import 'package:cloud_firestore/cloud_firestore.dart';
//esta es una clase singleton que se encarga de conectar con la bd y traer la coleccion.
class DatabaseService {
  final CollectionReference posteoCollection =
      FirebaseFirestore.instance.collection('posteo');

  Stream<QuerySnapshot<Map<String, dynamic>>> get posteosStream {
    return  FirebaseFirestore.instance.collection('posteo').snapshots();
  }
}