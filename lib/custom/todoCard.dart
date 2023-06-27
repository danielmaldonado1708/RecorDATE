import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    // Key key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.check,
    required this.iconBgcolor,
    required this.time,
    required this.onChange,
    required this.index,
  });

  final String title;
  final IconData iconData;
  final Color iconColor;
  final Timestamp time;
  final bool check;
  final Color iconBgcolor;
  final Function onChange;
  final int index;

// class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final timestamp = time as Timestamp;
    final planned_date = timestamp.toDate(); // Convertir a DateTime

    print('time que viene del dato');
    print(time);
    // final planned_date = time as DateTime;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          // Theme(
          //   data: ThemeData(
          //       primarySwatch: Colors.blue,
          //       unselectedWidgetColor: Color(0xff5e616a)
          //   ),
          //   child: Transform.scale(
          //     scale: 1.5,
          //     child: Checkbox(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(5),
          //           side: BorderSide(
          //             color: (check) ? Color(0xff6cf8a9) : Colors.grey,
          //             width: (check)
          //                 ? 2.0
          //                 : 1.0, // Ancho del borde ajustado cuando está seleccionado
          //           ),
          //         ),
          //         activeColor: Colors.transparent,
          //         checkColor: Colors.transparent,
          //         value: check,
          //         onChanged: (bool? value) {
          //           onChange(index);
          //         },
          //       )
          //   ),
            
          // ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 40,
                      width: 36,
                      decoration: BoxDecoration(
                        color: iconBgcolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        iconData,
                        color: iconColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  8), // Espacio entre el título y la fecha/hora
                          Text(
                            '${planned_date.day.toString()}/${planned_date.month.toString()}/${planned_date.year.toString()} ${planned_date.hour.toString()}:${planned_date.minute.toString()}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
