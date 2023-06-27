import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/pages/SignInPage.dart';
import 'package:recordate/pages/SignUpPage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthClass authClass = AuthClass();
  String currentUserName = '';

  @override
  void initState() {
    super.initState();
    // Obtén el usuario actualmente autenticado
    _getCurrentUserName();
  }

  Future<void> _getCurrentUserName() async {
    final user = await authClass.getUserName();
    print('obteniendo nombre');
    print(user);
    setState(() {
      currentUserName = user as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87, // Color de fondo del AppBar
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Retrocede a la pantalla anterior
          },
          icon: Icon(
            CupertinoIcons.arrow_left, // Icono de flecha hacia la izquierda
            color: Colors.white, // Color del icono
            size: 28, // Tamaño del icono
          ),
        ),
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                currentUserName,
                style: const TextStyle(
                    fontSize: 33,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logoutButton(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    color: Colors.white,
                    iconSize: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
          child: InkWell(
            onTap: () async {
              await authClass.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => SignInPage()),
                  (route) => false);
            },
            child: Text(
              'Cerrar Sesión',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
