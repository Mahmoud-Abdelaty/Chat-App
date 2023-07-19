// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constant.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String? email, password, name;
  GlobalKey<FormState> formKey = GlobalKey();
  UserCredential? userCredential;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          blur: 10,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: formKey,
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
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Email',
                      validator: (data)
                      {
                        if(data!.isEmpty)
                          {
                            return '       Email mustn\'t be Empty';
                          }
                      },
                      onChanged: (data)
                      {
                        email = data ;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      hintText: 'Password',
                      validator: (data)
                      {
                        if(data!.isEmpty)
                          {
                            return '       Password mustn\'t be Empty';
                          }
                      },
                      onChanged: (data)
                      {
                        password = data;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () async{
                        if(formKey.currentState!.validate())
                          {
                            isLoading = true;
                            setState(() {});
                            try {
                              UserCredential user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                              );
                              Navigator.pushNamedAndRemoveUntil(context, ChatPage.id , (route) => false);
                            }
                            on FirebaseAuthException catch(e)
                            {
                              if(e.code == 'weak-password')
                              {
                                showSnackBar(context,'Weak Password',Colors.red);
                              }
                              else if(e.code == 'email-already-in-use')
                              {
                                showSnackBar(context,'The account already exists for that email',Colors.red);
                              }
                            }
                          }
                        isLoading = false;
                        setState(() {});
                      },
                      text: 'Register',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        const Text(
                          'Already have an account ?',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        GestureDetector(
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '   Login',
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


}
