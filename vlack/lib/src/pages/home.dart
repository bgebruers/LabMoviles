import 'package:blackner/src/pages/addPost.dart';
import 'package:blackner/src/pages/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:blackner/src/pages/firstPage.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int _currentIndex = 0;

  final List<Widget> _pages = [
    // aca se agregan las pantallas
    Container(
        child: Center(
          child: firstPage(),     //hacer el login
        ),
    ),
    Container(
      child: Center(
        child: addPost(),
      ),
    ),
    Container(
      child: Center(
        child: ProfilePage(),
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
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

