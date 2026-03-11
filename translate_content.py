#!/usr/bin/env python3
"""
translate_content.py — Hugo blog yazılarını TR'den EN ve DE'ye çevirir.

Kullanım:
  python translate_content.py

Yapı:
  content/seyahat/*.md        → TR (mevcut)
  content/en/seyahat/*.md     → EN (üretilecek)
  content/de/seyahat/*.md     → DE (üretilecek)
  content/en/almanya/*.md     → EN
  content/de/almanya/*.md     → DE

Gereksinim:
  pip install anthropic
  ANTHROPIC_API_KEY .env dosyasında olmalı
"""

import os
import re
import time
import anthropic
from pathlib import Path

# ── Config ────────────────────────────────────────────────────────────────────
REPO_ROOT = Path(__file__).parent

def load_env():
    env_path = REPO_ROOT / ".env"
    if env_path.exists():
        for line in env_path.read_text().splitlines():
            if "=" in line and not line.startswith("#"):
                k, v = line.split("=", 1)
                os.environ.setdefault(k.strip(), v.strip())

load_env()

client = anthropic.Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY", ""))

# Çevrilecek dosyalar: (kaynak_path, en_hedef, de_hedef)
CONTENT_MAP = [
    ("content/seyahat/gurcistan-tiflis-batum-gezi-rehberi.md",
     "content/en/seyahat/gurcistan-tiflis-batum-gezi-rehberi.md",
     "content/de/seyahat/gurcistan-tiflis-batum-gezi-rehberi.md"),

    ("content/seyahat/tiflis-batum-gormedikleriniz-sakli-yerler.md",
     "content/en/seyahat/tiflis-batum-gormedikleriniz-sakli-yerler.md",
     "content/de/seyahat/tiflis-batum-gormedikleriniz-sakli-yerler.md"),

    ("content/seyahat/bosna-hersek-saraybosna-gezi-rehberi.md",
     "content/en/seyahat/bosna-hersek-saraybosna-gezi-rehberi.md",
     "content/de/seyahat/bosna-hersek-saraybosna-gezi-rehberi.md"),

    ("content/seyahat/kosova-pristine-prizren-gezi-rehberi.md",
     "content/en/seyahat/kosova-pristine-prizren-gezi-rehberi.md",
     "content/de/seyahat/kosova-pristine-prizren-gezi-rehberi.md"),

    ("content/seyahat/uskup-kuzey-makedonya-gezi-rehberi.md",
     "content/en/seyahat/uskup-kuzey-makedonya-gezi-rehberi.md",
     "content/de/seyahat/uskup-kuzey-makedonya-gezi-rehberi.md"),

    ("content/seyahat/yunanistan-atina-gezi-rehberi.md",
     "content/en/seyahat/yunanistan-atina-gezi-rehberi.md",
     "content/de/seyahat/yunanistan-atina-gezi-rehberi.md"),

    ("content/seyahat/isvicre-zurih-gezi-rehberi.md",
     "content/en/seyahat/isvicre-zurih-gezi-rehberi.md",
     "content/de/seyahat/isvicre-zurih-gezi-rehberi.md"),

    ("content/seyahat/isvicre-basel-3-ulke-gezi-rehberi.md",
     "content/en/seyahat/isvicre-basel-3-ulke-gezi-rehberi.md",
     "content/de/seyahat/isvicre-basel-3-ulke-gezi-rehberi.md"),

    ("content/seyahat/schengen-vizesi-alma-sureci.md",
     "content/en/seyahat/schengen-vizesi-alma-sureci.md",
     "content/de/seyahat/schengen-vizesi-alma-sureci.md"),

    ("content/seyahat/ucuz-ucak-bileti-nasil-bulunur.md",
     "content/en/seyahat/ucuz-ucak-bileti-nasil-bulunur.md",
     "content/de/seyahat/ucuz-ucak-bileti-nasil-bulunur.md"),

    ("content/almanya/almanya-ehliyet-yenileme-sureci.md",
     "content/en/almanya/almanya-ehliyet-yenileme-sureci.md",
     "content/de/almanya/almanya-ehliyet-yenileme-sureci.md"),

    ("content/hakkimda.md",
     "content/en/hakkimda.md",
     "content/de/hakkimda.md"),
]


# ── Çeviri fonksiyonu ─────────────────────────────────────────────────────────
def translate(content: str, target_lang: str) -> str:
    """
    Markdown içeriği çevirir.
    Front matter'daki title, description, tags çevrilir.
    featureimage, date, draft, categories değişmez.
    Markdown yapısı (tablolar, başlıklar, linkler) korunur.
    """
    lang_name = "English" if target_lang == "en" else "German"
    lang_instruction = (
        "Translate to natural, fluent English. Keep a personal, friendly tone."
        if target_lang == "en"
        else "Übersetze ins natürliche, flüssige Deutsch. Behalte einen persönlichen, freundlichen Ton."
    )

    prompt = f"""You are translating a Turkish travel blog post to {lang_name}.

{lang_instruction}

Rules:
- Translate the ENTIRE file including front matter fields: title, description, tags
- Do NOT translate or change: date, draft, featureimage, categories, slug values
- Keep ALL markdown formatting exactly: tables, headers, bullet points, bold, links
- Keep Turkish place names as-is (Tiflis, Batum, Prizren, etc.)
- Keep prices, numbers, distances as-is
- Tags should be translated to {lang_name} SEO keywords (20 tags, relevant for {lang_name} speakers searching for travel info)
- Return ONLY the translated markdown file, no explanation, no code blocks

File to translate:
---
{content}
---"""

    message = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=8000,
        messages=[{"role": "user", "content": prompt}]
    )

    result = message.content[0].text.strip()
    # Eğer code block içinde döndürdüyse temizle
    result = re.sub(r'^```[a-z]*\n?', '', result)
    result = re.sub(r'\n?```$', '', result)
    return result


# ── Ana fonksiyon ─────────────────────────────────────────────────────────────
def main():
    print(f"📁 Repo: {REPO_ROOT}\n")

    for tr_path, en_path, de_path in CONTENT_MAP:
        src = REPO_ROOT / tr_path
        if not src.exists():
            print(f"⏭️  Atlandı (kaynak yok): {tr_path}")
            continue

        content = src.read_text(encoding="utf-8")

        for target_lang, dest_path in [("en", en_path), ("de", de_path)]:
            dest = REPO_ROOT / dest_path

            if dest.exists():
                print(f"⏭️  Zaten var: {dest_path}")
                continue

            # Klasörü oluştur
            dest.parent.mkdir(parents=True, exist_ok=True)

            print(f"🔄 Çevriliyor [{target_lang.upper()}]: {tr_path}")
            try:
                translated = translate(content, target_lang)
                dest.write_text(translated, encoding="utf-8")
                print(f"   ✅ → {dest_path}")
                time.sleep(1)  # API rate limit için kısa bekleme
            except Exception as e:
                print(f"   ❌ Hata: {e}")

    print("\n✅ Tamamlandı!")
    print("\nŞimdi push et:")
    print("  git add -A && git commit -m 'feat: EN/DE translations' && git push")


if __name__ == "__main__":
    main()
