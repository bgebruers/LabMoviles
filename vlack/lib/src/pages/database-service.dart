import 'package:cloud_firestore/cloud_firestore.dart';
//esta es una clase singleton que se encarga de conectar con la bd y traer la coleccion.
class DatabaseService {
  final CollectionReference posteoCollection =
      FirebaseFirestore.instance.collection('posteo');

  Stream<QuerySnapshot<Map<String, dynamic>>> get posteosStream {
    return  FirebaseFirestore.instance.collection('posteo').snapshots();
  }

  void cargarPost(String username, String date, String media, String texto, String valoracion) {
  posteoCollection.add({
    'nombreUsuario': username,
    'date': date,
    'media': media,
    'texto': texto,
    'valoracion': valoracion,
  })
  .then((_) {
    // Éxito: los datos se agregaron correctamente
    print('Datos agregados con éxito');
  })
  .catchError((error) {
    // Error: ocurrió un error al agregar los datos
    print('Error al agregar datos: $error');
  });
}
}