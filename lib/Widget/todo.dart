import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Model%20Azqar/Model_toDoList.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_TO_DO.dart';

class Todo extends StatefulWidget {
  final Model_todoloist list;
  const Todo({required this.list, super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 5,
      color:  Color.fromARGB(255, 3, 102, 92),
      child: ListTile(
        title: Text(
          widget.list.title, 
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          widget.list.description, 
          style: GoogleFonts.cairo(
            fontSize: 16,
            color: const Color.fromARGB(255, 206, 205, 205),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                BlocProvider.of<CubitToDo>(context).deleteTask(widget.list.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
