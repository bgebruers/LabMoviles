import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addPost extends StatefulWidget {
  @override
  _addPostState createState() => _addPostState();
}


class addPostForm extends StatefulWidget {
  @override
  _addPostState createState() => _addPostState();
}

class _addPostState extends State<addPost> {
  final TextEditingController _contentController = TextEditingController();
  int maxCharacters = 250; // Límite de caracteres inicial
  String currentDateTime = '';    //variable para guardar la fecha y dia


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
              controller: _contentController,
              decoration: InputDecoration(
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
                  String content = _contentController.text;
                  if (content.isNotEmpty) {
                    // Procesa y publica el contenido según tus necesidades
                    // Puedes mostrar un mensaje de confirmación o realizar otras acciones aquí
                    print('Contenido publicado: $content');     //content es el mensaje, ese va a la bd
                    captureDateTime(); //fecha y hora capturada

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

//funcion para capturar la fecha 
void captureDateTime() {
  DateTime now = DateTime.now();
  String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(now); // Formatea la hora como "HH:mm:ss"
  setState(() {
    //agregar la fecha al mensaje y guardar en la bd
    currentDateTime = formattedDateTime;
  });
}
}