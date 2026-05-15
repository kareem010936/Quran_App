````md
# تطبيق القرآن الكريم 📖

تطبيق إسلامي متكامل تم تطويره باستخدام Flutter، يساعد المستخدم في قراءة القرآن الكريم، الأذكار، الأدعية، التسبيح، معرفة مواقيت الصلاة، وتنظيم المهام اليومية بطريقة عصرية وسهلة.

---

# مميزات التطبيق ✨

- 📖 قراءة القرآن الكريم كامل
- 🕌 عرض مواقيت الصلاة حسب المدينة
- 🌙 أذكار الصباح والمساء
- 🤲 قسم الأدعية الإسلامية
- 📿 سبحة إلكترونية
- ✅ ToDo List لتنظيم المهام
- 🔐 تسجيل دخول وإنشاء حساب باستخدام Firebase
- 💾 حفظ البيانات محليًا باستخدام SQLite & SharedPreferences
- 🎨 تصميم إسلامي عصري ومتجاوب

---

# هيكل المشروع 🗂️

```bash
lib/
│
├── Api_/
│   ├── Api.dart
│   ├── Api_Ayat.dart
│   ├── ApiListayat.dart
│   └── Api_Prayer.dart
│
├── Cubit_of_Aqar/
│   ├── Cubit.dart
│   ├── Cubit_of_List_Ayat.dart
│   ├── Cubit_of_List_Suraht.dart
│   ├── Cubit_TO_DO.dart
│   └── State.dart
│
├── Model Azqar/
│   ├── Model_Azqar.dart
│   ├── Model_Ayat.dart
│   ├── Model_List_Surah.dart
│   └── Model_toDoList.dart
│
├── Screens/
│   ├── AuthGate.dart
│   ├── LoginScreen.dart
│   ├── SignUpScreen.dart
│   ├── ForgetPasswordScreen.dart
│   ├── Home.dart
│   ├── LocationScreen.dart
│   ├── DuaScreen.dart
│   ├── azqar.dart
│   ├── Listsurah.dart
│   ├── Surah_ayat.dart
│   ├── TasbeehScreen.dart
│   └── Todolist.dart
│
├── SQL/
│   └── SQL.dart
│
├── Widget/
│   ├── Azqar.dart
│   ├── Prayer.dart
│   ├── Surah.dart
│   ├── Surah_Ayat.dart
│   └── todo.dart
│
├── firebase_options.dart
└── main.dart
````

---

# التقنيات المستخدمة 🛠️

* Flutter
* Dart
* Firebase Authentication
* Cubit / Bloc
* HTTP API
* SQLite
* SharedPreferences
* Google Fonts
* Font Awesome Icons

---

# صور من التطبيق 📱

<p align="center">
  <img src="assets/img_4.png" width="100%" />
</p>

---

# تثبيت المشروع 🚀

```bash
git clone https://github.com/kareem010936/Quran_App.git

cd Quran_App

flutter pub get

flutter run
```

---

# المطور 👨‍💻

Developed by Kareem Mohamed ❤️

```
```
