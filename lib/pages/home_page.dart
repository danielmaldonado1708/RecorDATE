import 'package:flutter/material.dart';
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/custom/todoCard.dart';
import 'package:recordate/pages/SignUpPage.dart';
import 'package:recordate/pages/addTodo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Tareas pendientes',
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/dog.png'),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  'Martes 27',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => AddTodoPage()),
                );
              },
              child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.indigoAccent, Colors.purple])),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            label: ''),
      ]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      TodoCard(
                        title: "Levantarse",
                        check: true,
                        iconBgcolor: Colors.white,
                        iconColor: Colors.red,
                        iconData: Icons.alarm,
                        time: "7 AM",
                      ),
                      TodoCard(
                        title: "Ejercicio",
                        check: true,
                        iconBgcolor: Color(0xff2cc8d9),
                        iconColor: Colors.white,
                        iconData: Icons.run_circle,
                        time: "8 AM",
                      ),
                      TodoCard(
                        title: "Continuar proyecto",
                        check: true,
                        iconBgcolor: Color(0xfff19733),
                        iconColor: Colors.white,
                        iconData: Icons.computer,
                        time: "9:30 AM",
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

/// para usar mas adelante -  cerrar sesion
///
// IconButton(
//     onPressed: () async {
//       await authClass.logout();
//       // ignore: use_build_context_synchronously
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (builder) => SignUpPage()),
//           (route) => false);
//     },
//     icon: const Icon(Icons.logout)
// )
