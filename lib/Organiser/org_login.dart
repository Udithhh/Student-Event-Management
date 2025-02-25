import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Organiser/org_navigation.dart';
import 'package:flutter_application_1/Organiser/org_register.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class OrgLogin extends StatefulWidget {
  const OrgLogin({super.key});

  @override
  State<OrgLogin> createState() => _OrgLoginState();
}

class _OrgLoginState extends State<OrgLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Organizer Login")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => signIn(),
                child: Text("Login"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrgRegister()),
                  );
                },
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      final user = await AuthService().orgSignInWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        var organizerSnapshot = await FirebaseFirestore.instance
            .collection('organizer')
            .where('email', isEqualTo: emailController.text.trim())
            .limit(1)
            .get();

        if (organizerSnapshot.docs.isNotEmpty) {
          var organizerData = organizerSnapshot.docs.first;
          String organizerName = organizerData['name'];

          var eventSnapshot = await FirebaseFirestore.instance
              .collection('events')
              .where('organizer', isEqualTo: organizerName)
              .limit(1)
              .get();

          if (eventSnapshot.docs.isNotEmpty) {
            var eventData = eventSnapshot.docs.first;
            String eventId = eventData.id;
            String eventName = eventData['event_name'];

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrganizationHome(eventId: eventId, eventName: eventName),
              ),
            );
          } else {
            scaffoldMess("No event assigned to this organizer.", context);
          }
        } else {
          scaffoldMess("Organizer not found in database.", context);
        }
      } else {
        scaffoldMess('User not found', context);
      }
    } catch (e) {
      scaffoldMess("Error: ${e.toString()}", context);
    }
  }
}

void scaffoldMess(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
