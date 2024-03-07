import 'package:flutter/material.dart';
import 'package:my_app/presentation/home_screen/view/home_screen.dart';
import 'package:my_app/presentation/register_screen/view/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var auth = FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final valid = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.phone),
          backgroundColor: Colors.amber,
          title: const Text("Login"),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.notification_add),
            ),
          ]),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image(
                  width: 100,
                  image: NetworkImage(
                    "https://lush.com.ph/cdn/shop/articles/sunflower_petal_infusion_1024x1024.jpg?v=1562727399",
                  )),
            ),
            SizedBox(
              height: 80,
            ),
            Form(
              key: valid,
              child: Column(
                children: [
                  TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Email address";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email Adress",
                        // hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (valid.currentState!.validate()) {
                            try {
                              final credential =
                                  await auth.signInWithEmailAndPassword(
                                email: _email.text,
                                password: _password.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                            print(_email.text);
                            print(_password.text);
                          }
                        },
                        child: Text("Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      )),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 30),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
