import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/pages/SignInPage.dart';
import 'package:recordate/pages/SignUpPage.dart';
import 'package:recordate/pages/add_todo.dart';
import 'package:recordate/pages/home_page.dart';
// import 'package:recordate/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC7VXT3OcPotirTID8fu75Jee_imZub40g', // apiKey
    appId: '1:867087829860:android:a71232b9502aba743b8871', // appId
    messagingSenderId: '867087829860', // messagingSenderId
    projectId: 'proyecto-todo-36e06', // projectId
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key = const Key('myApp')}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignInPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      print('sesion activa');
      setState(() {
        currentPage = HomePage();
      });
    } else {
      print('no hay sesion activa');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: currentPage,
      );
  }
}
