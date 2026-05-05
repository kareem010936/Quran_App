import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_TO_DO.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Model Azqar/Model_toDoList.dart';
import 'package:quran/Widget/todo.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "قائمة المهام",
          style: GoogleFonts.tajawal(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0e6058),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.9),
          child: BlocBuilder<CubitToDo, Appstate>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuccessStateofTODO) {
                if (state.todo.isEmpty) {
                  return const Center(
                    child: Text(
                      "لا توجد مهام بعد!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: state.todo.length,
                  itemBuilder: (context, index) {
                    return Todo(
                      list: Model_todoloist.fromMap(state.todo[index]),
                    );
                  },
                );
              } else if (state is ErrorState) {
                return Center(
                  child: Text(
                    "حدث خطأ: ${state.error}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                );
              }

              return const Center(
                child: Text(
                  "لا توجد مهام بعد!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () {
            final cubit = BlocProvider.of<CubitToDo>(context);
            _showAddTaskBottomSheet(context, cubit);
          },
          backgroundColor: const Color(0xFF0e6058),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context, CubitToDo cubit) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "إضافة مهمة",
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(_titleController, "عنوان المهمة", Icons.title),
              const SizedBox(height: 10),
              _buildTextField(
                  _detailsController, "تفاصيل المهمة", Icons.description),
              const SizedBox(height: 10),
              _buildDateField(context),
              const SizedBox(height: 10),
              _buildTimeField(context),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _detailsController.text.isNotEmpty &&
                      _dateController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty) {
                    cubit.addTask(
                      _titleController.text,
                      _detailsController.text,
                      _dateController.text,
                      _timeController.text,
                    );

                    _titleController.clear();
                    _detailsController.clear();
                    _dateController.clear();
                    _timeController.clear();

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("يرجى ملء جميع الحقول"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0e6058),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("إضافة المهمة"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today),
        hintText: "تاريخ المهمة",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
        }
      },
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return TextField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.access_time),
        hintText: "وقت المهمة",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          _timeController.text = pickedTime.format(context);
        }
      },
    );
  }
}
