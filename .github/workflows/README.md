# GitHub Actions for Flutter App

## 📱 Available Workflows

### 1. Build All Platforms (`build-all-platforms.yml`)
**الأكثر شمولية** - يبني التطبيق على جميع المنصات

**الميزات:**
- ✅ Android APK & AAB
- ✅ iOS Build
- ✅ Web Build
- ✅ Windows Build
- ✅ Linux Build

**متى يعمل:**
- عند Push لأي branch
- عند Pull Request
- يدوياً من GitHub Actions

### 2. Build Android (`build-android.yml`)
**مخصص لـ Android فقط**

**الميزات:**
- ✅ APK File
- ✅ App Bundle (AAB)
- ✅ App Icon Generation

### 3. Build iOS (`build-ios.yml`)
**مخصص لـ iOS فقط**

**الميزات:**
- ✅ iOS Build
- ✅ App Icon Generation

### 4. Build Web (`build-web.yml`)
**مخصص لـ Web فقط**

**الميزات:**
- ✅ Web Build
- ✅ Static Files

## 🚀 كيفية الاستخدام

### تشغيل تلقائي:
```bash
# عند عمل push للكود
git push origin cursor/update-upload-artifact-action-to-v4-9c37
```

### تشغيل يدوي:
1. اذهب إلى GitHub Repository
2. اختر تبويب "Actions"
3. اختر "Build All Platforms"
4. اضغط "Run workflow"

## 📦 الملفات المُنتجة

### Android:
- `app-release.apk` - ملف APK للتثبيت
- `app-release.aab` - ملف App Bundle لـ Google Play

### iOS:
- `ios-build/` - ملفات iOS Build

### Web:
- `web-build/` - ملفات Web Static

### Windows:
- `windows-build/` - ملفات Windows Executable

### Linux:
- `linux-build/` - ملفات Linux Executable

## ⚙️ الإعدادات

### Flutter Version:
- **الإصدار**: 3.16.9
- **القناة**: stable

### Java Version:
- **الإصدار**: 17
- **التوزيعة**: Zulu

### Supported Platforms:
- **Ubuntu**: Android, Web, Linux
- **macOS**: iOS
- **Windows**: Windows

## 🔧 التخصيص

### تغيير Flutter Version:
```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.16.9'  # غير هذا الرقم
```

### تغيير Java Version:
```yaml
- name: Setup Java
  uses: actions/setup-java@v4
  with:
    java-version: '17'  # غير هذا الرقم
```

### إضافة منصة جديدة:
```yaml
new-platform:
  runs-on: ubuntu-latest
  name: Build New Platform
  
  steps:
  - name: Checkout code
    uses: actions/checkout@v4
    
  - name: Setup Flutter
    uses: subosito/flutter-action@v2
    with:
      flutter-version: '3.16.9'
      
  - name: Get dependencies
    run: flutter pub get
    
  - name: Build New Platform
    run: flutter build new-platform --release
```

## 📊 مراقبة الأداء

### وقت البناء التقريبي:
- **Android**: ~5-10 دقائق
- **iOS**: ~8-15 دقيقة
- **Web**: ~3-5 دقائق
- **Windows**: ~5-8 دقائق
- **Linux**: ~4-7 دقائق

### حجم الملفات:
- **APK**: ~15-25 MB
- **AAB**: ~10-20 MB
- **Web**: ~2-5 MB
- **Windows**: ~20-30 MB
- **Linux**: ~15-25 MB

## 🎯 النصائح

1. **استخدم Build All Platforms** للحصول على جميع الملفات
2. **راجع الـ Artifacts** بعد اكتمال البناء
3. **اختبر الملفات** قبل النشر
4. **احتفظ بالملفات** لمدة 90 يوم

---

**🎉 Actions جاهزة للاستخدام!** 🚀