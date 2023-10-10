import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './posteo.dart';
import './database-service.dart';

class firstPage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: databaseService.posteosStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;
        //se crea la listViw de los mensajes que vienen de la coleccion de la bd.
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final posteoMap = data.docs[index].data();
            final posteo = Posteo.fromMap(posteoMap);

            return _PosteoItem(posteo);
          },
        );
      },
    );
  }
}
//clase para acomodar y mostrar los datos de cada coleccion.
class _PosteoItem extends StatelessWidget {
  final Posteo posteo;

  _PosteoItem(this.posteo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                posteo.nombreUsuario,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:Text(
                posteo.texto,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Alinea elementos a la derecha
                children: [
                  //widget que permite capturar evento, en este caso el onTap en las estrellas
                  GestureDetector(
                    onTap: () {
                      // Implementa aquí la lógica para puntuar el posteo
                    },
                    child: Row(
                      children: [
                        Text(
                          posteo.valoracion,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        PopupMenuButton<int>(
                          icon: Icon(Icons.star, color: Colors.amber),
                          itemBuilder: (BuildContext context) {
                            return List.generate(6, (index) {
                              return PopupMenuItem<int>(
                                value: index,
                                child: Text('$index'), 
                              );
                            });
                          },
                          onSelected: (int value) {
                            // Implementa aquí la lógica para guardar la puntuación
                          },
                        ),
                      
                      ],
                    ),
                  ),
                  Text("          "),//espaciado artesanal para que se separe la valoracion y la fecha
                  Text(
                    posteo.date,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
