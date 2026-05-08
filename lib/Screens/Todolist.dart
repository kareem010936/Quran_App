import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/Cubit_of_Aqar/Cubit_TO_DO.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Model%20Azqar/Model_toDoList.dart';
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0e6058),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "قائمة المهام",
          style: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withOpacity(0.92),
          child: BlocBuilder<CubitToDo, Appstate>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuccessStateofTODO) {
                if (state.todo.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "لا توجد مهام بعد!",
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "اضغط على الزر لإضافة مهمة جديدة",
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
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
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }

              return const Center(
                child: Text(
                  "لا توجد مهام بعد!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () {
            final cubit = BlocProvider.of<CubitToDo>(context);
            _showAddTaskBottomSheet(context, cubit);
          },
          backgroundColor: const Color(0xFF0e6058),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            "مهمة جديدة",
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context, CubitToDo cubit) {
    _titleController.clear();
    _detailsController.clear();
    _dateController.clear();
    _timeController.clear();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "إضافة مهمة",
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _titleController,
                        "عنوان المهمة",
                        Icons.title,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        _detailsController,
                        "تفاصيل المهمة",
                        Icons.description,
                      ),
                      const SizedBox(height: 12),
                      _buildDateField(context),
                      const SizedBox(height: 12),
                      _buildTimeField(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
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
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "إضافة المهمة",
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF0e6058)),
        hintText: hint,
        hintStyle: GoogleFonts.cairo(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0e6058), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF0e6058)),
        hintText: "تاريخ المهمة",
        hintStyle: GoogleFonts.cairo(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0e6058), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
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
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.access_time, color: Color(0xFF0e6058)),
        hintText: "وقت المهمة",
        hintStyle: GoogleFonts.cairo(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0e6058), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
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
