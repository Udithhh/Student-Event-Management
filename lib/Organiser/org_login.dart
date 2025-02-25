import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/org_home.dart';
import 'package:flutter_application_1/Organiser/org_register.dart';
import 'package:flutter_application_1/Student/st_register.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => signIn(),
                child: Text("login"),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrgRegister()));
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      final user = await AuthService().orgSignInWithEmail(
          emailController.text.trim(), passwordController.text.trim());

      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrgHome()));
      } else {
        scaffoldMess('User not fount', context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
    }
  }
}
