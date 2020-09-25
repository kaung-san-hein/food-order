import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/providers/auth.dart';
import 'package:food_order/src/screens/home.dart';
import 'package:food_order/src/screens/login.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/logo.png",
                        width: 240,
                        height: 240,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: authProvider.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: authProvider.email,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            icon: Icon(Icons.email),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: authProvider.password,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (!await context.read<AuthProvider>().signUp()) {
                          _key.currentState.showSnackBar(
                            SnackBar(content: Text("Register Failed!")),
                          );
                          return;
                        }
                        context.read<AuthProvider>().clearController();
                        changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: red,
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Register",
                                size: 22,
                                color: white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      authProvider.clearController();
                      changeScreen(context, Login());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: "Login here", size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
