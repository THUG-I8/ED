# 🔧 حل المشاكل الشائعة

## ❌ مشاكل البناء

### 1. خطأ FontFeature
```
Error: 'FontFeature' isn't a type.
```

**الحل:**
- تم تحديث `google_fonts` إلى الإصدار `^5.1.0`
- تشغيل `flutter clean` ثم `flutter pub get`

### 2. خطأ في الخطوط
```
Error: unable to locate asset entry in pubspec.yaml
```

**الحل:**
- تم إزالة الخطوط المفقودة من `pubspec.yaml`
- استخدام خطوط النظام المتاحة

### 3. خطأ في النماذج
```
Error: Type 'Ayah' not found
```

**الحل:**
- تم تحديث النماذج لتتوافق مع البيانات الفعلية
- استخدام `Verse` بدلاً من `Ayah`

## 🚀 حل مشاكل التشغيل

### 1. Flutter غير مثبت
```bash
# تثبيت Flutter
# اتبع التعليمات في https://flutter.dev/docs/get-started/install
```

### 2. Android SDK غير مثبت
```bash
# تثبيت Android Studio
# إعداد Android SDK
```

### 3. مشاكل في التبعيات
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

## 📱 مشاكل التطبيق

### 1. التطبيق لا يفتح
- تأكد من تثبيت APK صحيح
- إعادة تشغيل الجهاز
- مسح بيانات التطبيق

### 2. مشاكل في العرض
- تأكد من دعم اللغة العربية
- تحديث إعدادات الجهاز

### 3. مشاكل في الأداء
- إغلاق التطبيقات الأخرى
- مسح ذاكرة التخزين المؤقت

## 🎨 مشاكل App Icon

### 1. الأيقونة لا تظهر
```bash
flutter pub run flutter_launcher_icons:main
flutter clean
flutter build apk --release
```

### 2. حجم الأيقونة غير صحيح
- تأكد من أن الصورة 1024x1024 بكسل
- استخدام تنسيق PNG
- خلفية صلبة (غير شفافة)

## 📞 الحصول على المساعدة

إذا لم تحل المشكلة:
1. تحقق من [GitHub Issues](link-to-issues)
2. ابحث عن حلول مشابهة
3. أنشئ issue جديد مع تفاصيل المشكلة

---

**نتمنى لكم تجربة سلسة!** 🚀