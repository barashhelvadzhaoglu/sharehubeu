import os

def update_years_to_2026(content_dir="content"):
    print("--- TARİH GÜNCELLEME OPERASYONU (2025 -> 2026) ---")
    count = 0
    
    # Tüm alt klasörleri tara (tr, en, de)
    for root, dirs, files in os.walk(content_dir):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()

                # Eğer dosya içinde 2025 tarihi geçiyorsa değiştir
                if "date: 2025" in content:
                    new_content = content.replace("date: 2025", "date: 2026")
                    
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    
                    print(f"[GÜNCELLENDİ] {file_path}")
                    count += 1

    print(f"\nİşlem tamamlandı. Toplam {count} dosya 2026 yılına çekildi.")

if __name__ == "__main__":
    update_years_to_2026()