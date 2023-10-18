import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './posteo.dart';
import './database-service.dart';
import 'package:http/http.dart' as http;

final DatabaseService databaseService = DatabaseService();

class firstPage extends StatelessWidget {
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
                child: posteo.media != ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posteo.texto,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    imagen, // Muestra la imagen si media no está vacío
                  ],
                )
              : Text(
                    posteo.texto,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
            
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                          icon: const Icon(Icons.star, color: Colors.amber),
                          itemBuilder: (BuildContext context) {
                            return List.generate(6, (index) {
                              return PopupMenuItem<int>(
                                value: index,
                                child: Text('$index'),
                              );
                            });
                          },
                          onSelected: (int value) {
                            databaseService.actualizarValoracion(
                                posteo.nombreUsuario, posteo.texto, value.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                  Text("          "),
                  Text(
                    posteo.date,
                    style: const TextStyle(
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
 //trae la imagen con la url almacenada en el campo media de la base de datos
  Widget get imagen{
    return Image.network(posteo.media);
  }
}
