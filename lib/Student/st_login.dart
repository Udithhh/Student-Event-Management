import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/std_home.dart';
import 'package:flutter_application_1/Student/st_register.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class StLogin extends StatefulWidget {
  const StLogin({super.key});

  @override
  State<StLogin> createState() => _StLoginState();
}

class _StLoginState extends State<StLogin> {
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
                onPressed: () => signIn(),
                child: Text("login"),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StRegister()));
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
      final user = await AuthService().signInWithEmail(
          emailController.text.trim(), passwordController.text.trim());

      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StdHome()));
      } else {
        scaffoldMess('User not fount', context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
    }
  }
}
