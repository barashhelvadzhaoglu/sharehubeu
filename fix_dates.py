import os
import datetime

def check_hugo_files(content_dir="content"):
    print(f"{'DOSYA YOLU':<50} | {'TARİH':<12} | {'DRAFT':<7}")
    print("-" * 75)
    
    for root, dirs, files in os.walk(content_dir):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                file_date = "N/A"
                draft_status = "N/A"
                
                with open(file_path, 'r', encoding='utf-8') as f:
                    for line in f:
                        if line.startswith("date:"):
                            file_date = line.split(":", 1)[1].strip().replace('"', '').replace("'", "")[:10]
                        if line.startswith("draft:"):
                            draft_status = line.split(":", 1)[1].strip()
                
                print(f"{file_path[-50:]:<50} | {file_date:<12} | {draft_status:<7}")

if __name__ == "__main__":
    check_hugo_files()