import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/login_page.dart';
import 'package:scholar_chat/screens/register_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id : (context) =>  LoginPage(),
        RegisterPage.id : (context) =>  RegisterPage(),
        ChatPage.id : (context) => ChatPage(),
      },
        // home: FirebaseAuth.instance.currentUser!.uid == null ? LoginPage() : ChatPage(),
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null ? LoginPage.id : ChatPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}

