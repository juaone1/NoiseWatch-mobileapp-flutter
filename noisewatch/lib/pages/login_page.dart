import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noisewatch/components/round_tile.dart';
import 'package:noisewatch/utils/utils.dart';

import '../components/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.red[900],
              ),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 30,
              ),
              //icon
              Icon(
                Icons.play_circle_outline,
                color: Colors.red[900],
                size: 100,
              ),
              const SizedBox(height: 5),
              //appname
              Text(
                'NOISEWATCH',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900),
              ),
              const SizedBox(height: 40),
              //welcome
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Welcome back!',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //username textfield
              MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  )),
              const SizedBox(height: 25),
              //password textfield
              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: const Icon(
                    Icons.password_rounded,
                    color: Colors.white,
                  )),
              const SizedBox(height: 40),
              //sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(w, h * .08),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.red[900]),
                    onPressed: signIn,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              const SizedBox(height: 40),
              //or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.white60,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.white60,
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 30),
              //google button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [RoundTile(imagePath: 'lib/assets/google.png')],
              ),
              //dont have an account
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.red[900], fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
