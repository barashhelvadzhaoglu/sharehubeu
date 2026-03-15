import os
import datetime

# Bugünün tarihi
today = datetime.date.today().isoformat()

def fix_hugo_dates(content_dir="content"):
    print(f"Bugünün tarihi: {today}")
    
    for root, dirs, files in os.walk(content_dir):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()

                modified = False
                has_draft_line = False
                date_found = False
                new_lines = []

                for line in lines:
                    # Tarihi bul
                    if line.startswith("date:"):
                        file_date = line.split(":", 1)[1].strip().replace('"', '').replace("'", "")
                        # Sadece YYYY-MM-DD kısmını al (varsa saati at)
                        file_date = file_date[:10]
                        
                        if file_date > today:
                            print(f"İleri tarih tespit edildi: {file_path} ({file_date})")
                            date_found = True
                        new_lines.append(line)
                    
                    elif line.startswith("draft:"):
                        has_draft_line = True
                        if date_found: # Eğer tarih ileriyse draft'ı true yap
                            new_lines.append("draft: true\n")
                            modified = True
                        else:
                            new_lines.append(line)
                    else:
                        new_lines.append(line)

                # Eğer tarih ileriyse ama draft satırı hiç yoksa, date'den sonra ekle
                if date_found and not has_draft_line:
                    final_lines = []
                    for line in new_lines:
                        final_lines.append(line)
                        if line.startswith("date:"):
                            final_lines.append("draft: true\n")
                    new_lines = final_lines
                    modified = True

                if modified:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.writelines(new_lines)

if __name__ == "__main__":
    fix_hugo_dates()
    print("İşlem tamamlandı.")