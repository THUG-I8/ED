#!/usr/bin/env python3
import base64

# أيقونة PNG بسيطة (أخضر مع هلال)
icon_data = """
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==
"""

# فك تشفير البيانات
icon_bytes = base64.b64decode(icon_data.strip())

# حفظ الأيقونة
with open('assets/icon/icon.png', 'wb') as f:
    f.write(icon_bytes)

print("✅ تم إنشاء أيقونة بسيطة!")
print("📁 الموقع: assets/icon/icon.png")
print("🎯 الآن يمكنك استبدالها بأيقونتك!")