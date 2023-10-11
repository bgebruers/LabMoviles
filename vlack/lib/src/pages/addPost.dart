import 'package:blackner/src/pages/posteo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './database-service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './variableGlobal.dart';

class addPost extends StatefulWidget {
  @override
  _addPostState createState() => _addPostState();
}


class addPostForm extends StatefulWidget {
  @override
  _addPostState createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  final DatabaseService databaseService = DatabaseService();

  final TextEditingController _contentController = TextEditingController();
  int maxCharacters = 250; // Límite de caracteres inicial
  String currentDateTime = '';
  
  String formattedDateTime = ''; // Variable de instancia para la fecha y hora

  //captura la fecha y la hora
  void captureDateTime() {
    DateTime now = DateTime.now();
    formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
  }

  //funcion para recortar la cantidad de caracteres permitidos para agregar 
  void _reduceCharacterLimit() {
    setState(() {
      maxCharacters = 100; // Cambiar el límite de caracteres a 100
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //box para agregar el contenido
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              //controlador para capturar lo que el usuario ingresa
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Agregar Contenido',
                border: InputBorder.none,
              ),
              maxLines: null, // Permite múltiples líneas de texto
              maxLength: maxCharacters, // Límite de caracteres dinámico
            ),
          ),
          SizedBox(height: 16.0),
          //row para botones de video e imagen
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.videocam, color: Colors.grey),
                    onPressed: () {
                      // Lógica para agregar video
                      // Puedes cambiar el límite de caracteres aquí
                      _reduceCharacterLimit();
                    },
                  ),
                ],
              ),
              SizedBox(width: 8.0), // Espacio entre los botones
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.image, color: Colors.grey),
                    onPressed: () {
                      // Lógica para agregar imagen
                      // Puedes cambiar el límite de caracteres aquí
                      _reduceCharacterLimit();
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          //row para boton de publicar 
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el botón "Publicar"
            children: [
              ElevatedButton(
                onPressed: () {
                  // Lógica para publicar el contenido
                  String contenido = _contentController.text;
                   if (contenido.isNotEmpty) {
                    
                    captureDateTime(); // Captura la fecha y hora
                    String date = formattedDateTime; // Accede a formattedDateTime

                    databaseService.cargarPost(VariableGlobal.userName, date, "", contenido, "");


                  } else {
                      // Muestra un mensaje de error si el campo está vacío
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, ingresa contenido antes de publicar.'),
                      ),
                    );
                  }
                 
                },
                child: Text('Publicar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}