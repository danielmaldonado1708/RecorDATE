// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/custom/todoCard.dart';
import 'package:recordate/pages/SignUpPage.dart';
import 'package:recordate/pages/add_todo.dart';
import 'package:recordate/pages/profilePage.dart';
import 'package:recordate/pages/viewData.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  late String currentUserId;
  late Stream<QuerySnapshot> _stream =
      Stream.empty(); // Inicializar con una lista vacía
  List<Select> selected = [];

  @override
  void initState() {
    super.initState();
    // Obtener el ID del usuario actualmente autenticado
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    final user = await authClass.getUserId();
    setState(() {
      currentUserId = user as String;
      _stream = FirebaseFirestore.instance
          .collection("todo")
          .where("userId", isEqualTo: currentUserId)
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');

    DateTime now = DateTime.now();
    String formattedDate_hoy = DateFormat('E d MMM.', 'es').format(now);

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
            backgroundImage: AssetImage('assets/profile.png'),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDate_hoy,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       var instance =
                    //           FirebaseFirestore.instance.collection('todo');

                    //       for (var i = 0; i < selected.length; i++) {
                    //         instance
                    //             .doc(selected[i].id)
                    //             .delete()
                    //             .then((value) => {
                    //                   // Navigator.pop(context)
                    //                 });
                    //       }
                    //     },
                    //     icon: Icon(
                    //       Icons.delete,
                    //       color: Colors.red,
                    //       size: 28,
                    //     )),
                  ],
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
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => Profile()),
                );
              },
              child: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
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
            if (!(snapshot.data?.docs?.isNotEmpty ?? false)) {
              //la expresión no es nula y la lista de documentos está vacía
              return Center(
                child: Text(
                  'Comienza agregando una tarea...',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
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

                  selected.add(Select(
                      id: snapshot.data?.docs[index].id ?? '',
                      checkValue: false));

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ViewDataPage(
                                    document: document,
                                    id: snapshot.data?.docs[index].id ?? '',
                                  )));
                    },
                    child: TodoCard(
                      title: document['title'] == null
                          ? 'Sin título'
                          : document['title'],
                      check: selected[index].checkValue,
                      iconBgcolor: Color(0xff2cc8d9),
                      iconColor: iconColor,
                      iconData: iconData,
                      time: document['planned_date'] == null
                          ? DateTime.now()
                          : document['planned_date'],
                      index: index,
                      onChange: onChange,
                    ),
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
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

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
