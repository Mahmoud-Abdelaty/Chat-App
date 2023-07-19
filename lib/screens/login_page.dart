// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

   static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? email, password,name;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
        return Form(
          key: formKey,
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            blur: 10,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children:
                  [
                    Spacer(
                      flex: 2,
                    ),
                    Image.asset(kLogo),
                    Text(
                        'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      children:
                      [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Email',
                      onChanged: (data)
                      {
                        email = data;
                      },
                      validator: (data)
                      {
                        if(data!.isEmpty)
                          {
                            return '       Email mustn\'t be Empty';
                          }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Password',
                      onChanged: (data)
                      {
                        password = data;
                      },
                      validator: (data)
                      {
                        if(data!.isEmpty)
                        {
                          return '       Password mustn\'t be Empty';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Login',
                      onTap: ()
                      async {
                        if(formKey.currentState!.validate())
                          {
                            isLoading = true;
                            setState(() {});
                            try {
                              await loginUser();
                              Navigator.pushNamedAndRemoveUntil(context, ChatPage.id , (route) => false);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                              showSnackBar(context, 'No user found for that email.', Colors.red);
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(context, 'Wrong password provided for that user.', Colors.red);
                              }
                            }
                          }
                        isLoading = false;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Text(
                          'dont\'t have an account ?',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            '   Register',
                            style: TextStyle(
                                color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  Future<void> loginUser() async {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
