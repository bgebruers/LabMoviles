import 'package:blackner/src/pages/addPost.dart';
import 'package:blackner/src/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:blackner/src/pages/firstPage.dart';

class Vlack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // aca se agregan las pantallas
    Container(
        child: Center(
          child: firstPage(),
        ),
    ),
    Container(
      child: Center(
        child: addPost(),
      ),
    ),
    Container(
      child: Center(
        child: profilePage(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Vlack',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: _pages[_currentIndex], // Muestra la página actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Cambia la página al hacer click en una pestaña
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          //son los botones del tab para navegar
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Agregar Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
