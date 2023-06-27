import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff1d1e26),
          Color(0xff252041),
        ])), // BoxDecoration
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
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
                    Text(
                      'Crear',
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Nueva tarea',
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // label('Tarea'),
                    SizedBox(
                      height: 20,
                    ),
                    title(),
                    SizedBox(
                      height: 30,
                    ),
                    label('Tipo de tarea'),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        chipData('Importante', 0xff2664fa),
                        SizedBox(
                          width: 20,
                        ),
                        chipData('Baja prioridad', 0xff1aa8c9),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    // label('Descripción'),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 30,
                    ),
                    label('Categoría'),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        chipData('Facultad', 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        chipData('Trabajo', 0xfff29732),
                        SizedBox(
                          width: 20,
                        ),
                        chipData('Hogar', 0xff6557ff),
                        SizedBox(
                          width: 20,
                        ),
                        chipData('Ejercicio', 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    button(),
                    SizedBox(
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
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
          Color(0xff8a32f1),
          Color(0xffad32f9),
        ]),
      ),
      child: Center(
        child: Text('Guardar tarea', style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
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

  Widget chipData(String label, int color) {
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(
        label,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Color(0xff2a2e3d),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Nueva tarea',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
          hintText: 'Ingrese una nueva tarea',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
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
}
