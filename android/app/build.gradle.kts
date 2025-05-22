plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.pfc_mobile"
    compileSdk = flutter.compileSdkVersion
    // FIX: Override flutter.ndkVersion with the specific version required by your plugins
    ndkVersion = "27.0.12077973" // <-- CHANGE THIS LINE!

    compileOptions {
        // You might need to adjust these based on your Java/Kotlin setup and other dependencies
        // If you encounter issues with these versions, revert to 1.8.
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.pfc_mobile"
        minSdk = 21 // Keep this at 21 or higher if your plugins require it
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