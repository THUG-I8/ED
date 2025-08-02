# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Vibration plugin rules
-keep class com.benjaminabel.vibration.** { *; }
-dontwarn com.benjaminabel.vibration.**

# Geolocator plugin rules
-keep class com.baseflow.geolocator.** { *; }
-dontwarn com.baseflow.geolocator.**

# Permission handler rules
-keep class com.baseflow.permissionhandler.** { *; }
-dontwarn com.baseflow.permissionhandler.**

# HTTP plugin rules
-keep class io.flutter.plugins.http.** { *; }
-dontwarn io.flutter.plugins.http.**

# Shared preferences rules
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-dontwarn io.flutter.plugins.sharedpreferences.**

# Provider rules
-keep class io.flutter.plugins.provider.** { *; }
-dontwarn io.flutter.plugins.provider.**

# Google Fonts rules
-keep class io.flutter.plugins.googlefonts.** { *; }
-dontwarn io.flutter.plugins.googlefonts.**

# Remove debug logs in release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
}

# Optimize for performance
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-optimizationpasses 5
-allowaccessmodification

# Keep all classes that might be used by reflection
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keepattributes Signature
-keepattributes Exceptions

# Keep classes that might be used by plugins
-keep class * extends androidx.fragment.app.Fragment { *; }
-keep class * extends android.app.Activity { *; }
-keep class * extends android.app.Application { *; }