// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recordate/Service/auth_service.dart';
import 'package:recordate/pages/home_page.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  AuthClass authClass = AuthClass();
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    // Obtén el usuario actualmente autenticado
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    final user = await authClass.getUserId();
    print('obteniendo id de user en add todo');
    print(user);
    setState(() {
      currentUserId = user as String;
    });
  }
  
  String type = '';
  String category = '';

  DateTime dateTime = DateTime(2023, 06, 27, 12, 30);
  // DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Crear',
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Nueva tarea',
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // label('Tarea'),
                    const SizedBox(
                      height: 20,
                    ),
                    title(),
                    const SizedBox(
                      height: 30,
                    ),
                    label('Tipo de tarea'),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelect('Importante', 0xff2664fa),
                        const SizedBox(
                          width: 20,
                        ),
                        taskSelect('Baja prioridad', 0xff1aa8c9),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // label('Descripción'),
                    const SizedBox(
                      height: 12,
                    ),
                    description(),
                    const SizedBox(
                      height: 30,
                    ),
                    label('Categoría'),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect('Facultad', 0xffff6d6e),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Trabajo', 0xfff29732),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Hogar', 0xff6557ff),
                        const SizedBox(
                          width: 20,
                        ),
                        categorySelect('Personal', 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    label('Fecha y hora asignada'),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 56,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87,
                            // gradient: const LinearGradient(colors: [
                              // Color(0xff8a32f1),
                              // Color(0xffad32f9),
                            // ]),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                              onPressed: () async {
                                final date = await pickDate();
                                if (date == null) return;
                                final newDateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    dateTime.hour,
                                    dateTime.minute);
                        
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              },
                              child: Text(
                                  '${dateTime.day}/${dateTime.month}/${dateTime.year}', style: TextStyle(color: Colors.white),)
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 56,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87,
                            // gradient: const LinearGradient(colors: [
                            //   Color(0xff8a32f1),
                            //   Color(0xffad32f9),
                            // ]),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                              onPressed: () async {
                                final time = await pickTime();
                                if (time == null) return;
                        
                                final newDateTime = DateTime(
                                    dateTime.year,
                                    dateTime.month,
                                    dateTime.day,
                                    time.hour,
                                    time.minute);
                        
                                setState(() {
                                  dateTime = newDateTime;
                                });
                              },
                              child: Text('${hours}:${minutes}', style: TextStyle(color: Colors.white),)),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    button(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* ================================ 
    componentes
  ================================ */

  Widget button() {
    return InkWell(
      onTap: () {
        // print('boton presionado');
        FirebaseFirestore.instance.collection('todo').add({
          'userId': currentUserId,
          'title': _titleController.text,
          'description': _descriptionController.text,
          "category": category,
          "planned_date": dateTime,
          'task': type,
        });

        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: const Center(
          child: Text(
            'Guardar tarea',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      // height: 150,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        // height: 150,
        child: TextFormField(
          controller: _descriptionController,
          maxLines: null,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Descripción',
            labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
            hintText: 'Escriba la descripción de la tarea',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Color(0xff2a2e3d),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: (type == label) ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: (type == label) ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: (category == label) ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: (category == label) ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Color(0xff2a2e3d),
      //   borderRadius: BorderRadius.circular(15),
      // ),j
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: _titleController,
        decoration: InputDecoration(
          labelText: 'Nueva tarea',
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 17),
          hintText: 'Ingrese una nueva tarea',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Color(0xff2a2e3d),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
}
