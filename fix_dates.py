import os

# Senin paylaştığın listedeki ileri tarihli (15 Mart'tan sonraki) dosyalar
target_files = [
    "content/de/deutschland/salzburg-reisefuehrer.md",
    "content/de/deutschland/augsburg-reisefuehrer.md",
    "content/de/deutschland/schloss-neuschwanstein-reisefuehrer.md",
    "content/de/deutschland/regensburg-reisefuehrer.md",
    "content/de/deutschland/lindau-reisefuehrer.md",
    "content/de/deutschland/silvester-deutschland-muenchen.md",
    "content/de/deutschland/fuessen-reisefuehrer.md",
    "content/de/deutschland/deutschlandticket-muenchen-tagesausfluege.md",
    "content/de/deutschland/ingolstadt-reisefuehrer.md",
    "content/de/deutschland/wohnung-mieten-muenchen.md",
    "content/en/germany/regensburg-travel-guide.md",
    "content/en/germany/new-years-eve-germany-silvester.md",
    "content/en/germany/renting-in-germany-munich.md",
    "content/en/germany/memmingen-travel-guide.md",
    "content/en/germany/deutschlandticket-munich-day-trips.md",
    "content/en/germany/augsburg-travel-guide.md",
    "content/en/germany/ingolstadt-travel-guide.md",
    "content/en/germany/lindau-lake-constance-travel-guide.md",
    "content/en/germany/fuessen-town-travel-guide.md",
    "content/en/germany/neuschwanstein-castle-guide.md",
    "content/en/germany/salzburg-day-trip-munich.md",
    "content/tr/almanya/regensburg-gezi-rehberi.md",
    "content/tr/almanya/memmingen-gezi-rehberi.md",
    "content/tr/almanya/fuessen-sehir-gezi-rehberi.md",
    "content/tr/almanya/salzburg-gezi-rehberi.md",
    "content/tr/almanya/augsburg-gezi-rehberi.md",
    "content/tr/almanya/deutschlandticket-munih-cevresinde-gezi.md",
    "content/tr/almanya/lindau-bodensee-gezi-rehberi.md",
    "content/tr/almanya/ingolstadt-gezi-rehberi.md",
    "content/tr/almanya/almanyada-yilbasi-kutlamalari.md",
    "content/tr/almanya/almanyada-kira-bulma-rehberi.md",
    "content/tr/almanya/neuschwanstein-kalesi-gezi-rehberi.md"
]

def apply_manual_fix():
    print(f"--- MANUEL OPERASYON BAŞLADI ---")
    updated_count = 0
    
    for file_path in target_files:
        if os.path.exists(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()

            modified = False
            draft_found = False
            
            # Satır satır kontrol ve değişim
            for i, line in enumerate(lines):
                if line.strip().startswith("draft:"):
                    lines[i] = "draft: true\n"
                    draft_found = True
                    modified = True
            
            # Eğer dosyada hiç draft satırı yoksa, date satırının altına ekle
            if not draft_found:
                for i, line in enumerate(lines):
                    if line.strip().startswith("date:"):
                        lines.insert(i + 1, "draft: true\n")
                        modified = True
                        break

            if modified:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.writelines(lines)
                print(f"[OK] {file_path}")
                updated_count += 1
        else:
            print(f"[HATA] Dosya bulunamadı: {file_path}")

    print(f"\nİşlem bitti. Toplam {updated_count} dosya draft:true yapıldı.")

if __name__ == "__main__":
    apply_manual_fix()