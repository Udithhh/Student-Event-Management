import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/add_event.dart';
import 'package:flutter_application_1/Admin/org_home.dart';
import 'package:flutter_application_1/Admin/std_home.dart';

class CustomNav extends StatefulWidget {
  const CustomNav({super.key});

  @override
  State<CustomNav> createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  int _currentIndex = 0;
  final _screens = [const OrgHome(), const AddEvent(), const StdHome()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Student'),
        ],
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      body: _screens[_currentIndex],
    );
  }
}
