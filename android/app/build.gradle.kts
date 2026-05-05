plugins {
    id("com.android.application")

    // 🔥 Firebase
    id("com.google.gms.google-services")

    // 🔥 Kotlin (صح)
    id("org.jetbrains.kotlin.android")

    // Flutter
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.quran"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.quran"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}