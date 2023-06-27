import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/custom/todoCard.dart';
import 'package:recordate/pages/SignUpPage.dart';
import 'package:recordate/pages/addTodo.dart';
import 'package:recordate/pages/viewData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('todo').snapshots();
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
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;

                  IconData iconData;
                  Color iconColor;

                  switch (document['category']) {
                    case 'Facultad':
                      iconData = Icons.menu_book_sharp;
                      iconColor = Colors.deepOrange;
                      break;
                    case 'Trabajo':
                      iconData = Icons.laptop;
                      iconColor = Colors.indigo;
                      break;
                    case 'Hogar':
                      iconData = Icons.home;
                      iconColor = Colors.white;
                      break;
                    case 'Personal':
                      iconData = Icons.person;
                      iconColor = Colors.red;
                      break;
                    default:
                      iconData = Icons.radio_button_unchecked;
                      iconColor = Colors.white;
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ViewDataPage(
                              document: document,
                              id: snapshot.data?.docs[index].id ?? '',
                            )
                          )
                      );
                    },
                    child: TodoCard(
                      title: document['title'] == null
                          ? 'Sin título'
                          : document['title'],
                      check: true,
                      iconBgcolor: Color(0xff2cc8d9),
                      iconColor: iconColor,
                      iconData: iconData,
                      time: "8 AM",
                    ),
                  );
                });
          }),
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
