import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/custom_nav.dart';
import 'package:flutter_application_1/Organiser/org_login.dart';
import 'package:flutter_application_1/Student/st_login.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CustomNav()));
                },
                child: Text("Admin")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrgLogin()));
                },
                child: Text("Organiser")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StLogin()));
                },
                child: Text("Student"))
          ],
        ),
      ),
    );
  }
}
