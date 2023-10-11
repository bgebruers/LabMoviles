import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './posteo.dart';
import './database-service.dart';
import './variableGlobal.dart';

String username = VariableGlobal.userName;

class ProfilePage extends StatelessWidget {
  final DatabaseService databaseService = DatabaseService();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              margin: EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4.0,
                ),
                // Foto de perfil que vendria desde la bd
            /*   image: DecorationImage(
                  image: AssetImage('assets/profile_image.jpg'), // Ruta de la imagen de perfil
                  fit: BoxFit.cover,
                ),*/
              ),
            ),
            // Información del usuario que vendría también desde la base de datos
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Correo Electrónico: blas.gebruers@gmail.com\nEdad: 22 años\nUbicación: General Pico, La Pampa, Argentina',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                // Se crea la ListView de los mensajes que vienen de la colección de la base de datos.
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    final posteoMap = data.docs[index].data();
                    final posteo = Posteo.fromMap(posteoMap);

                    return _PosteoItem(posteo);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PosteoItem extends StatelessWidget {
  final Posteo posteo;

  _PosteoItem(this.posteo);

  
  @override
  Widget build(BuildContext context) {
    if(posteo.nombreUsuario == username){
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
              child: Text(
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
                  GestureDetector(
                    onTap: () {
                      // lugar para implementrar la logica del putuar 
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
    }else {
      // Devuelve un widget vacío si el nombre del usuario ingresado no corresponse con el que se traer desde la bd
      return SizedBox();
    }

  }
}

