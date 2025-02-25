import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Organiser/org_login.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class OrgStdList extends StatefulWidget {
  final String eventId;
  final String eventName;

  const OrgStdList({super.key, required this.eventId, required this.eventName});

  @override
  State<OrgStdList> createState() => _OrgStdListState();
}

class _OrgStdListState extends State<OrgStdList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("events")
            .doc(widget.eventId)
            .collection("students_applied")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var students = snapshot.data!.docs;

          if (students.isEmpty) {
            return Center(child: Text("No students applied yet."));
          }

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var data = students[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name'] ?? "No Name"),
                subtitle: Text("Email: ${data['email'] ?? 'No Email'}"),
                leading: Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }

  // Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => _logout(), // Logout function
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  // Logout function
  void _logout() async {
    await AuthService().orgLogout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OrgLogin()),
      (route) => false,
    );
  }
}
