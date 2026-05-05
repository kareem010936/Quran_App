# تطبيق القرآن الكريم - Clean Architecture

## هيكل المشروع

```
lib/
├── core/                          # إعدادات مشتركة
│   ├── app_constants.dart         → روابط API + أسماء Routes
│   └── app_theme.dart             → ألوان + styles
│
├── data/                          # طبقة البيانات
│   ├── api/
│   │   ├── quran_api.dart         → جلب السور والآيات من الإنترنت
│   │   └── azqar_api.dart         → جلب الأذكار من الإنترنت
│   ├── local/
│   │   └── local_database.dart    → حفظ المهام في SQLite
│   └── models/
│       ├── surah_model.dart       → بيانات السورة
│       ├── ayah_model.dart        → بيانات الآية
│       ├── zikr_model.dart        → بيانات الذكر
│       └── task_model.dart        → بيانات المهمة
│
├── state/                         # إدارة الحالة (Bloc/Cubit)
│   ├── states/
│   │   └── app_states.dart        → كل الحالات في ملف واحد
│   └── cubit/
│       ├── surahs_cubit.dart      → Cubit لقائمة السور
│       ├── ayahs_cubit.dart       → Cubit لآيات السورة
│       ├── azqar_cubit.dart       → Cubit للأذكار (صباح/مساء/صلاة)
│       └── tasks_cubit.dart       → Cubit لقائمة المهام
│
└── ui/                            # الشاشات والـ Widgets
    ├── screens/
    │   ├── login_screen.dart
    │   ├── signup_screen.dart
    │   ├── forget_password_screen.dart
    │   ├── location_screen.dart
    │   ├── home_screen.dart       → الشاشة الرئيسية + BottomNav
    │   ├── azqar_screen.dart
    │   ├── dua_screen.dart
    │   ├── tasbeeh_screen.dart
    │   ├── list_surah_screen.dart
    │   ├── surah_ayat_screen.dart
    │   └── todo_screen.dart
    └── widgets/
        ├── background_image.dart  → خلفية مشتركة بين كل الشاشات
        ├── zikr_card.dart
        ├── surah_card.dart
        ├── ayah_card.dart
        └── task_card.dart
```

---

## كيف الكود شغال؟

```
Screen → يستخدم BlocBuilder يراقب الـ Cubit
Cubit  → يستدعي API أو Database
API    → يرجع JSON ويحوله لـ Model
Model  → Object نظيف بيتعرض في الـ Screen
```

---

## التحسينات اللي اتعملت

| المشكلة القديمة | الحل |
|---|---|
| 3 Cubits للأذكار = 3 API calls | Cubit واحد يغير النوع حسب الـ Tab |
| States مبعثرة في أكثر من ملف | كل الـ States في `app_states.dart` |
| اسم الـ routes hardcoded في كل شاشة | `AppConstants` يحتوي كل الـ routes |
| `BackgroundImage` متكرر في كل شاشة | Widget مشترك واحد `BackgroundImage` |
| Models بأسماء صعبة (`Model_Azqar`) | أسماء واضحة: `ZikrModel`, `TaskModel` |

---

## Dependencies المطلوبة في pubspec.yaml

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  dio: ^5.3.2
  sqflite: ^2.3.0
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  google_fonts: ^6.1.0
  font_awesome_flutter: ^10.6.0
```
