import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class StRegister extends StatefulWidget {
  const StRegister({super.key});

  @override
  State<StRegister> createState() => _StRegisterState();
}

class _StRegisterState extends State<StRegister> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
                obscureText: true, // ✅ Hide password input
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => signUp(),
                child: Text("Register"),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    try {
      var user = await AuthService().signUpWithEmail(
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

void scaffoldMess(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
