#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
import os

def create_app_icon():
    # Create a 1024x1024 image with green background
    size = 1024
    img = Image.new('RGB', (size, size), color='#2E7D32')
    draw = ImageDraw.Draw(img)
    
    # Draw a simple crescent moon (white circle with offset)
    moon_outer = (int(size * 0.4), int(size * 0.2), int(size * 0.8), int(size * 0.6))
    moon_inner = (int(size * 0.5), int(size * 0.2), int(size * 0.7), int(size * 0.6))
    
    # Draw outer circle
    draw.ellipse(moon_outer, fill='white')
    # Draw inner circle (creates crescent effect)
    draw.ellipse(moon_inner, fill='#2E7D32')
    
    # Draw a simple star
    star_points = []
    center_x, center_y = int(size * 0.3), int(size * 0.7)
    radius = int(size * 0.15)
    
    for i in range(10):
        angle = i * 36 * 3.14159 / 180
        if i % 2 == 0:
            r = radius
        else:
            r = radius * 0.4
        x = center_x + r * (1 if i % 2 == 0 else 0.4) * (1 if i < 5 else -1)
        y = center_y + r * (1 if i % 2 == 0 else 0.4) * (1 if i % 5 < 2.5 else -1)
        star_points.append((x, y))
    
    # Draw star
    draw.polygon(star_points, fill='white')
    
    # Add Arabic text (simplified)
    try:
        # Try to use a font that supports Arabic
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", int(size * 0.08))
    except:
        # Fallback to default font
        font = ImageFont.load_default()
    
    text = "اعرف دينك"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    text_x = (size - text_width) // 2
    text_y = int(size * 0.85)
    
    draw.text((text_x, text_y), text, fill='white', font=font)
    
    # Ensure directory exists
    os.makedirs('assets/images', exist_ok=True)
    
    # Save the icon
    img.save('assets/images/app_icon.png')
    print("App icon created successfully at assets/images/app_icon.png")

if __name__ == "__main__":
    create_app_icon()