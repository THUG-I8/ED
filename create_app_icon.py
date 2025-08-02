#!/usr/bin/env python3
"""
سكريبت لإنشاء أيقونة تطبيق إسلامية
"""
from PIL import Image, ImageDraw, ImageFont
import os

def create_islamic_icon():
    # حجم الأيقونة (1024x1024 للجودة العالية)
    size = 1024
    icon = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(icon)
    
    # خلفية خضراء إسلامية
    background_color = (46, 125, 50)  # أخضر إسلامي
    draw.rectangle([0, 0, size, size], fill=background_color)
    
    # إنشاء دائرة بيضاء في المنتصف
    circle_center = size // 2
    circle_radius = size // 3
    circle_bbox = [
        circle_center - circle_radius,
        circle_center - circle_radius,
        circle_center + circle_radius,
        circle_center + circle_radius
    ]
    draw.ellipse(circle_bbox, fill=(255, 255, 255))
    
    # رسم هلال أخضر
    crescent_color = (46, 125, 50)
    # هلال كبير
    crescent_outer = [
        circle_center - circle_radius + 50,
        circle_center - circle_radius + 50,
        circle_center + circle_radius - 50,
        circle_center + circle_radius - 50
    ]
    crescent_inner = [
        circle_center - circle_radius + 100,
        circle_center - circle_radius + 50,
        circle_center + circle_radius - 100,
        circle_center + circle_radius - 50
    ]
    
    # رسم الهلال
    draw.ellipse(crescent_outer, fill=crescent_color)
    draw.ellipse(crescent_inner, fill=(255, 255, 255))
    
    # رسم نجمة صغيرة
    star_size = 30
    star_x = circle_center + circle_radius - 80
    star_y = circle_center - circle_radius + 80
    
    # رسم نجمة خماسية
    star_points = []
    for i in range(5):
        angle = i * 72 - 90  # دوران للنجمة
        x = star_x + star_size * 0.5 * (1 if i % 2 == 0 else 0.3) * (1 if angle % 180 == 0 else 0.5)
        y = star_y + star_size * 0.5 * (1 if i % 2 == 0 else 0.3) * (1 if angle % 180 == 90 else 0.5)
        star_points.append((x, y))
    
    draw.polygon(star_points, fill=(255, 215, 0))  # ذهبي
    
    # حفظ الأيقونة
    icon.save('assets/icon/icon.png', 'PNG')
    print("✅ تم إنشاء أيقونة التطبيق بنجاح!")
    print("📁 الموقع: assets/icon/icon.png")

if __name__ == "__main__":
    # إنشاء مجلد الأيقونات إذا لم يكن موجوداً
    os.makedirs('assets/icon', exist_ok=True)
    create_islamic_icon()