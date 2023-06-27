import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recordate/pages/home_page.dart';

class ViewDataPage extends StatefulWidget {
  const ViewDataPage({Key? key, required this.document, required this.id}) : super(key: key);
  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewDataPage> createState() => _ViewDataPageState();
}

class _ViewDataPageState extends State<ViewDataPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String type = '';
  String category = '';

  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document['title'] == null
        ? 'Sin título'
        : widget.document['title'];

    String description = widget.document['description'] == null
        ? 'Sin descripción'
        : widget.document['description'];

    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document['description']);
    type = widget.document['task'];
    category = widget.document['category'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 28,
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('todo')
                              .doc(widget.id)
                              .delete()
                              .then((value) => {
                                  Navigator.pop(context)
                              });

                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 28,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: (edit) ? Colors.green : Colors.white,
                          size: 28,
                    )),
                  ],
                ),
              ]),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? 'Editar' : 'Ver',
                      style: const TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Tarea',
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
                    edit ?
                    button() : Container(),
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
        print('boton presionado');
        FirebaseFirestore.instance.collection('todo').doc(widget.id).update({
          'title': _titleController.text,
          'description': _descriptionController.text,
          "category": category,
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
            'Modificar tarea',
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
          enabled: edit,
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
      onTap: edit ? () {
        setState(() {
          type = label;
        });
      } : null,
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
      onTap: edit ? () {
        setState(() {
          category = label;
        });
      } : null,
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
        enabled: edit,
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
}
