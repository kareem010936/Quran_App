import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Cubit_of_Aqar/Cubit.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Widget/Azqar.dart';

class Azqar extends StatefulWidget {
  const Azqar({super.key});

  @override
  State<Azqar> createState() => _AzqarState();
}

class _AzqarState extends State<Azqar> {
  int _currentIndex = 0;

  void _loadAzkar(int index, BuildContext context) {
    final cubit = context.read<AzqarCubit>();

    if (index == 0) {
      cubit.GetMorning();
    } else if (index == 1) {
      cubit.Getevening();
    } else {
      cubit.GetPrayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzqarCubit()..GetMorning(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0e6058),
              elevation: 0,
              title: const Text(
                "الأذكار",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildTopItem(
                            context: context,
                            index: 0,
                            label: "الصباح",
                            icon: FontAwesomeIcons.sun,
                          ),
                          _buildTopItem(
                            context: context,
                            index: 1,
                            label: "المساء",
                            icon: FontAwesomeIcons.moon,
                          ),
                          _buildTopItem(
                            context: context,
                            index: 2,
                            label: "الصلاة",
                            icon: FontAwesomeIcons.personPraying,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: BlocBuilder<AzqarCubit, Appstate>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ErrorState) {
                            return Center(
                              child: Text(
                                "حدث خطأ: ${state.error}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          } else if (state is SuccessState) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              itemCount: state.ls.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Azqarwidget(x: state.ls[index]),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: Text("لا توجد بيانات"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopItem({
    required BuildContext context,
    required int index,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
          _loadAzkar(index, context);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0e6058) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
