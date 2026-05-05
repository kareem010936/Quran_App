import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran/Cubit_of_Aqar/State.dart';
import 'package:quran/Model%20Azqar/Model_Azqar.dart';

class AzqarCubit extends Cubit<Appstate> {
  AzqarCubit() : super(InitialState());

  Future<void> GetMorning() async {
    emit(LoadingState());
    try {
      final List<Model_Azqar> sabah = [
        const Model_Azqar(
          name:
              "أصبحنا وأصبح الملك لله والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 1,
        ),
        const Model_Azqar(
          name: "اللهم بك أصبحنا وبك أمسينا وبك نحيا وبك نموت وإليك النشور",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "اللهم إني أصبحت أشهدك وأشهد حملة عرشك وملائكتك وجميع خلقك أنك أنت الله لا إله إلا أنت وحدك لا شريك لك وأن محمدًا عبدك ورسولك",
          counter: 4,
        ),
        const Model_Azqar(
          name:
              "اللهم ما أصبح بي من نعمة أو بأحد من خلقك فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر",
          counter: 1,
        ),
        const Model_Azqar(
          name: "رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد ﷺ نبيًا",
          counter: 3,
        ),
        const Model_Azqar(
          name: "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم",
          counter: 7,
        ),
        const Model_Azqar(
          name: "اللهم إني أسألك العفو والعافية في الدنيا والآخرة",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "اللهم إني أسألك خير هذا اليوم فتحه ونصره ونوره وبركته وهداه، وأعوذ بك من شر ما فيه وشر ما بعده",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "أصبحنا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد ﷺ، وعلى ملة أبينا إبراهيم حنيفًا مسلمًا وما كان من المشركين",
          counter: 1,
        ),
        const Model_Azqar(
          name: "سبحان الله وبحمده",
          counter: 100,
        ),
        const Model_Azqar(
          name:
              "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 10,
        ),
        const Model_Azqar(
          name: "أعوذ بكلمات الله التامات من شر ما خلق",
          counter: 3,
        ),
        const Model_Azqar(
          name: "اللهم صل وسلم على نبينا محمد",
          counter: 10,
        ),
        const Model_Azqar(
          name: "أستغفر الله العظيم وأتوب إليه",
          counter: 100,
        ),
      ];

      emit(SuccessState(ls: sabah));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> Getevening() async {
    emit(LoadingState());
    try {
      final List<Model_Azqar> evening = [
        const Model_Azqar(
          name:
              "أمسينا وأمسى الملك لله والحمد لله، لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 1,
        ),
        const Model_Azqar(
          name: "اللهم بك أمسينا وبك أصبحنا وبك نحيا وبك نموت وإليك المصير",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "اللهم إني أمسيت أشهدك وأشهد حملة عرشك وملائكتك وجميع خلقك أنك أنت الله لا إله إلا أنت وحدك لا شريك لك وأن محمدًا عبدك ورسولك",
          counter: 4,
        ),
        const Model_Azqar(
          name:
              "اللهم ما أمسى بي من نعمة أو بأحد من خلقك فمنك وحدك لا شريك لك، فلك الحمد ولك الشكر",
          counter: 1,
        ),
        const Model_Azqar(
          name: "رضيت بالله ربًا، وبالإسلام دينًا، وبمحمد ﷺ نبيًا",
          counter: 3,
        ),
        const Model_Azqar(
          name: "حسبي الله لا إله إلا هو عليه توكلت وهو رب العرش العظيم",
          counter: 7,
        ),
        const Model_Azqar(
          name: "اللهم إني أسألك العفو والعافية في الدنيا والآخرة",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "أمسينا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد ﷺ، وعلى ملة أبينا إبراهيم حنيفًا مسلمًا وما كان من المشركين",
          counter: 1,
        ),
        const Model_Azqar(
          name: "سبحان الله وبحمده",
          counter: 100,
        ),
        const Model_Azqar(
          name:
              "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 10,
        ),
        const Model_Azqar(
          name: "أعوذ بكلمات الله التامات من شر ما خلق",
          counter: 3,
        ),
        const Model_Azqar(
          name: "اللهم صل وسلم على نبينا محمد",
          counter: 10,
        ),
        const Model_Azqar(
          name: "أستغفر الله العظيم وأتوب إليه",
          counter: 100,
        ),
      ];

      emit(SuccessState(ls: evening));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  Future<void> GetPrayer() async {
    emit(LoadingState());
    try {
      final List<Model_Azqar> prayer = [
        const Model_Azqar(
          name: "أستغفر الله",
          counter: 3,
        ),
        const Model_Azqar(
          name: "اللهم أنت السلام ومنك السلام تباركت يا ذا الجلال والإكرام",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 1,
        ),
        const Model_Azqar(
          name:
              "اللهم لا مانع لما أعطيت، ولا معطي لما منعت، ولا ينفع ذا الجد منك الجد",
          counter: 1,
        ),
        const Model_Azqar(
          name: "سبحان الله",
          counter: 33,
        ),
        const Model_Azqar(
          name: "الحمد لله",
          counter: 33,
        ),
        const Model_Azqar(
          name: "الله أكبر",
          counter: 33,
        ),
        const Model_Azqar(
          name:
              "لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير",
          counter: 1,
        ),
        const Model_Azqar(
          name: "قراءة آية الكرسي",
          counter: 1,
        ),
        const Model_Azqar(
          name: "قراءة سورة الإخلاص",
          counter: 1,
        ),
        const Model_Azqar(
          name: "قراءة سورة الفلق",
          counter: 1,
        ),
        const Model_Azqar(
          name: "قراءة سورة الناس",
          counter: 1,
        ),
      ];

      emit(SuccessState(ls: prayer));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
