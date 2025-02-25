import 'package:flutter/material.dart';
import 'package:flutter_application_1/Organiser/org_event.dart';
import 'package:flutter_application_1/Organiser/org_std_list.dart';

class OrganizationHome extends StatefulWidget {
  final String eventId;
  final String eventName;

  const OrganizationHome(
      {super.key, required this.eventId, required this.eventName});

  @override
  State<OrganizationHome> createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          OrgStdList(eventId: widget.eventId, eventName: widget.eventName),
          OrgEvent(eventId: widget.eventId),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Students"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Event"),
        ],
      ),
    );
  }
}
