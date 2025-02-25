import 'package:flutter/material.dart';
import 'package:flutter_application_1/Student/st_register.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class OrgRegister extends StatefulWidget {
  const OrgRegister({super.key});

  @override
  State<OrgRegister> createState() => _OrgRegisterState();
}

class _OrgRegisterState extends State<OrgRegister> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
                controller: nameController,
                decoration: InputDecoration(hintText: "name"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => signUp(),
                child: Text("Register"),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      var user = await AuthService().orgSignUpWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );

      if (user != null) {
        scaffoldMess("Registration successful!", context);
        Navigator.pop(context);
      } else {
        scaffoldMess("Registration failed", context);
      }
    } catch (e) {
      scaffoldMess("Error: ${e.toString()}", context);
    }
  }
}
