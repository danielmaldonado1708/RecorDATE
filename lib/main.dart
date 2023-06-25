import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/pages/SignInPage.dart';
import 'package:recordate/pages/SignUpPage.dart';
import 'package:recordate/pages/home_page.dart';
// import 'package:recordate/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC7VXT3OcPotirTID8fu75Jee_imZub40g', // Your apiKey
    appId: '1:867087829860:android:a71232b9502aba743b8871', // Your appId
    messagingSenderId: '867087829860', // Your messagingSenderId
    projectId: 'proyecto-todo-36e06', // Your projectId
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key = const Key('myApp')}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignUpPage();
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
        currentPage = const HomePage();
      });
    } else {
      print('no hay sesion activa');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: currentPage);
  }
}
