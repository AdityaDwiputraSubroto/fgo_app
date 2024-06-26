import 'package:fgo_app/views/feedback_screen.dart';
import 'package:fgo_app/views/home_screen.dart';
import 'package:fgo_app/views/logout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fgo_app/views/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  final int selectedIndex;
  BottomNavbar({this.selectedIndex = 0});
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FeedbackScreen(),
    ProfileScreen(),
    LogoutScreen(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 183, 212, 235),
        onTap: _onItemTapped,
      ),
    );
  }
}
