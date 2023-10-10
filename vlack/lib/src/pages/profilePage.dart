import 'package:flutter/material.dart'; 
import './message.dart';

class profilePage extends StatelessWidget {
  //lista de mensajes que vendria desde la bd
  final List<Message> messages = [
    Message('Blas Gebruers', 'Mensaje 1', '4'), // 4 estrellas
    Message('Blas Gebruers', 'Mensaje 2', '3'), // 3 estrellas
    Message('Blas Gebruers', 'Mensaje 3', '5'), // 5 estrellas
    Message('Blas Gebruers', 'Mensaje 4', '2'), // 2 estrellas
    Message('Blas Gebruers', 'Mensaje 5', '1'), // 1 estrella
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto de perfil circular
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
            // Información del usuario que vendria tambien desde la bd
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Blas Gebruers',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                 Text(
                    'Correo Electrónico: blas.gebruers@gmail.com\nEdad: 22 años\nUbicación: General Pico, La Pampa, Argentina',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            // Lista de mensajes de un mismo usuario que vendria desde la bd
            ListView.separated(
              shrinkWrap: true,
              itemCount: messages.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (context, index) {
                final message = messages[index];

                return ListTile(
                 
                  //title: Text(message.text),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              message.label,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinea elementos a la izquierda y a la derecha
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end, // Alinea la calificación a la derecha
                            children: [
                            //alinear y que queden al lado
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    message.star.toString(), // Calificación como String
                                  ),
                                   //uso este menu para que cuando el usuario haga click en el icono se le despliegue un menu
                                   //del 0 al 5 para puntuar
                                   PopupMenuButton<int>(
                                      icon: Icon(Icons.star, color: Colors.amber,), // Icono de estrella
                                      
                                      itemBuilder: (BuildContext context) {
                                        return List.generate(6, (index) {
                                          return PopupMenuItem<int>(
                                            value: index,
                                            child: Text('$index'),
                                          );
                                        });
                                      },
                                      onSelected: (int value) {
                                        message.star = value.toString();
                                        //mandar a la bd y luego hacer el promedio de estrellas

                                      },
                                  ),
                                 
                                  
                                ],
                            )

                            ],
                        ),
                        ]
                      ),
                    ],
                  ),               
                 
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
