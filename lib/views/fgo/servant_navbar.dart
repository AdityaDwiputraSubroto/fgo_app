import 'package:fgo_app/views/feedback_screen.dart';
import 'package:fgo_app/views/fgo/servant_favorites.dart';
import 'package:fgo_app/views/home_screen.dart';
import 'package:fgo_app/views/fgo/servant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fgo_app/views/profile_screen.dart';

class ServantNavbar extends StatefulWidget {
  final int selectedIndex;
  ServantNavbar({this.selectedIndex = 0});
  @override
  _ServantNavbarState createState() => _ServantNavbarState();
}

class _ServantNavbarState extends State<ServantNavbar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ServantListScreen(),
    ServantFavoritesScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Servants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
