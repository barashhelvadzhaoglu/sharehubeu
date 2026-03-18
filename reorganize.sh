#!/bin/bash
# =============================================================================
# ShareHub - Klasör Reorganizasyon Scripti
# Çalıştırma: cd ~/Documents/sharehub && bash reorganize.sh
# =============================================================================

set -e
BASE="$HOME/Documents/sharehub"
CONTENT="$BASE/content"
CONFIG="$BASE/config/_default"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "🚀 ShareHub Reorganizasyon Scripti"
echo "==================================="
echo ""

# =============================================================================
# STEP 1: Alt klasörleri oluştur
# =============================================================================
echo -e "${BLUE}📂 STEP 1: Alt klasörler oluşturuluyor...${NC}"

mkdir -p "$CONTENT/en/germany/living"
mkdir -p "$CONTENT/en/germany/travel"
mkdir -p "$CONTENT/en/germany/expat"
mkdir -p "$CONTENT/tr/almanya/yasam"
mkdir -p "$CONTENT/tr/almanya/seyahat"
mkdir -p "$CONTENT/tr/almanya/expat"
mkdir -p "$CONTENT/de/deutschland/leben"
mkdir -p "$CONTENT/de/deutschland/reisen"
mkdir -p "$CONTENT/de/deutschland/expat"

echo -e "${GREEN}✅ Klasörler oluşturuldu${NC}"
echo ""

# =============================================================================
# STEP 2: EN dosyaları taşı
# =============================================================================
echo -e "${BLUE}📦 STEP 2: EN/germany dosyaları taşınıyor...${NC}"

move_file() {
  local src="$1"
  local dst="$2"
  if [ -f "$src" ]; then
    mv "$src" "$dst"
    echo -e "  ${GREEN}✓${NC} $(basename $src) → $(basename $(dirname $dst))/"
  else
    echo -e "  ${YELLOW}⚠ Bulunamadı:${NC} $(basename $src)"
  fi
}

# EN → living/
for f in \
  "trust-in-germany.md" \
  "why-i-moved-countries.md" \
  "turkey-vs-germany.md" \
  "06-health-system-turkey-vs-germany.md" \
  "07-shopping-turkey-vs-germany.md" \
  "08-food-turkey-vs-germany.md" \
  "09-housing-turkey-vs-germany.md" \
  "10-social-life-turkey-vs-germany.md" \
  "11-language-barrier-turkey-vs-germany.md" \
  "12-turkish-muslim-identity-germany.md" \
  "13-elderly-care-turkey-vs-germany.md" \
  "14-cars-traffic-turkey-vs-germany.md" \
  "15-work-life-turkey-vs-germany.md" \
  "16-kita-childcare-turkey-vs-germany.md" \
  "17-primary-school-turkey-vs-germany.md" \
  "18-bicultural-kids-turkey-vs-germany.md" \
  "19-climate-seasons-turkey-vs-germany.md" \
  "20-quality-of-life-final-verdict.md"; do
  move_file "$CONTENT/en/germany/$f" "$CONTENT/en/germany/living/$f"
done

# EN → travel/
for f in \
  "augsburg-travel-guide.md" \
  "fuessen-town-travel-guide.md" \
  "ingolstadt-travel-guide.md" \
  "lindau-lake-constance-travel-guide.md" \
  "memmingen-travel-guide.md" \
  "neuschwanstein-castle-guide.md" \
  "regensburg-travel-guide.md" \
  "salzburg-day-trip-munich.md" \
  "new-years-eve-germany-silvester.md" \
  "deutschlandticket-munich-day-trips.md"; do
  move_file "$CONTENT/en/germany/$f" "$CONTENT/en/germany/travel/$f"
done

# EN → expat/
for f in \
  "eu-series-01-netherlands.md" \
  "eu-series-02-luxembourg.md" \
  "eu-series-03-comparison-why-germany.md" \
  "eu-series-04-job-seeker-visa-germany-EN.md" \
  "renting-in-germany-munich.md" \
  "driving-license-renewal-germany.md" \
  "bulgarian-license-valid-in-germany.md"; do
  move_file "$CONTENT/en/germany/$f" "$CONTENT/en/germany/expat/$f"
done

echo ""

# =============================================================================
# STEP 3: TR dosyaları taşı
# =============================================================================
echo -e "${BLUE}📦 STEP 3: TR/almanya dosyaları taşınıyor...${NC}"

# TR → seyahat/
for f in \
  "augsburg-gezi-rehberi.md" \
  "fuessen-sehir-gezi-rehberi.md" \
  "ingolstadt-gezi-rehberi.md" \
  "lindau-bodensee-gezi-rehberi.md" \
  "memmingen-gezi-rehberi.md" \
  "neuschwanstein-kalesi-gezi-rehberi.md" \
  "regensburg-gezi-rehberi.md" \
  "salzburg-gezi-rehberi.md" \
  "almanyada-yilbasi-kutlamalari.md" \
  "deutschlandticket-munih-cevresinde-gezi.md"; do
  move_file "$CONTENT/tr/almanya/$f" "$CONTENT/tr/almanya/seyahat/$f"
done

# TR → expat/
for f in \
  "almanya-ehliyet-yenileme-sureci.md" \
  "almanyada-kira-bulma-rehberi.md" \
  "bulgar-ehliyeti-almanyada-gecerli-mi.md"; do
  move_file "$CONTENT/tr/almanya/$f" "$CONTENT/tr/almanya/expat/$f"
done

echo ""

# =============================================================================
# STEP 4: DE dosyaları taşı
# =============================================================================
echo -e "${BLUE}📦 STEP 4: DE/deutschland dosyaları taşınıyor...${NC}"

# DE → reisen/
for f in \
  "augsburg-reisefuehrer.md" \
  "fuessen-reisefuehrer.md" \
  "ingolstadt-reisefuehrer.md" \
  "lindau-reisefuehrer.md" \
  "regensburg-reisefuehrer.md" \
  "salzburg-reisefuehrer.md" \
  "schloss-neuschwanstein-reisefuehrer.md" \
  "silvester-deutschland-muenchen.md" \
  "deutschlandticket-muenchen-tagesausfluege.md"; do
  move_file "$CONTENT/de/deutschland/$f" "$CONTENT/de/deutschland/reisen/$f"
done

# DE → expat/
for f in \
  "bulgarischer-fuehrerschein-in-deutschland-gueltig.md" \
  "fuehrerschein-erneuerung-deutschland.md" \
  "fuehrerschein-umschreibung-deutschland.md" \
  "wohnung-mieten-muenchen.md"; do
  move_file "$CONTENT/de/deutschland/$f" "$CONTENT/de/deutschland/expat/$f"
done

echo ""

# =============================================================================
# STEP 5: _index.md dosyalarını oluştur
# =============================================================================
echo -e "${BLUE}📝 STEP 5: _index.md dosyaları oluşturuluyor...${NC}"

cat > "$CONTENT/en/germany/living/_index.md" << 'EOF'
---
title: "Living in Germany"
description: "Personal essays and honest comparisons between life in Turkey and Germany."
translationKey: "germany-living"
---
EOF
echo -e "  ${GREEN}✓${NC} en/germany/living/_index.md"

cat > "$CONTENT/en/germany/travel/_index.md" << 'EOF'
---
title: "Travel in Bavaria"
description: "Day trip guides around Munich and Bavaria, explored with family and a Deutschlandticket."
translationKey: "germany-travel-section"
---
EOF
echo -e "  ${GREEN}✓${NC} en/germany/travel/_index.md"

cat > "$CONTENT/en/germany/expat/_index.md" << 'EOF'
---
title: "Expat Guides"
description: "Practical guides for moving to Germany and Europe — visas, housing, driving licences and more."
translationKey: "germany-expat"
---
EOF
echo -e "  ${GREEN}✓${NC} en/germany/expat/_index.md"

cat > "$CONTENT/tr/almanya/yasam/_index.md" << 'EOF'
---
title: "Almanya'da Yaşam"
description: "Türkiye ve Almanya karşılaştırmaları ile Münih'te expat hayatına dair kişisel yazılar."
translationKey: "germany-living"
---
EOF
echo -e "  ${GREEN}✓${NC} tr/almanya/yasam/_index.md"

cat > "$CONTENT/tr/almanya/seyahat/_index.md" << 'EOF'
---
title: "Bavyera Gezi Rehberleri"
description: "Münih çevresinde Deutschlandticket ile aile dostu günübirlik gezi rehberleri."
translationKey: "germany-travel-section"
---
EOF
echo -e "  ${GREEN}✓${NC} tr/almanya/seyahat/_index.md"

cat > "$CONTENT/tr/almanya/expat/_index.md" << 'EOF'
---
title: "Expat Rehberleri"
description: "Almanya ve Avrupa'ya taşınmak için pratik rehberler — vize, kira, ehliyet ve daha fazlası."
translationKey: "germany-expat"
---
EOF
echo -e "  ${GREEN}✓${NC} tr/almanya/expat/_index.md"

cat > "$CONTENT/de/deutschland/leben/_index.md" << 'EOF'
---
title: "Leben in Deutschland"
description: "Persönliche Texte und ehrliche Vergleiche zwischen dem Leben in der Türkei und Deutschland."
translationKey: "germany-living"
---
EOF
echo -e "  ${GREEN}✓${NC} de/deutschland/leben/_index.md"

cat > "$CONTENT/de/deutschland/reisen/_index.md" << 'EOF'
---
title: "Reisen in Bayern"
description: "Tagesausflug-Guides rund um München und Bayern mit dem Deutschlandticket und Familie."
translationKey: "germany-travel-section"
---
EOF
echo -e "  ${GREEN}✓${NC} de/deutschland/reisen/_index.md"

cat > "$CONTENT/de/deutschland/expat/_index.md" << 'EOF'
---
title: "Expat-Ratgeber"
description: "Praktische Ratgeber für den Umzug nach Deutschland — Visum, Wohnung, Führerschein und mehr."
translationKey: "germany-expat"
---
EOF
echo -e "  ${GREEN}✓${NC} de/deutschland/expat/_index.md"

echo ""

# =============================================================================
# STEP 6: Menü dosyalarını güncelle
# =============================================================================
echo -e "${BLUE}⚙️  STEP 6: Menü dosyaları güncelleniyor...${NC}"

cat > "$CONFIG/menus.en.toml" << 'EOF'
[[main]]
  name = "Home"
  pageRef = "/"
  weight = 1

[[main]]
  name = "Germany"
  pageRef = "germany"
  weight = 2

[[main]]
  name = "Living"
  pageRef = "germany/living"
  parent = "Germany"
  weight = 1

[[main]]
  name = "Travel"
  pageRef = "germany/travel"
  parent = "Germany"
  weight = 2

[[main]]
  name = "Expat Guides"
  pageRef = "germany/expat"
  parent = "Germany"
  weight = 3

[[main]]
  name = "Travel"
  pageRef = "travel"
  weight = 3

[[main]]
  name = "About"
  pageRef = "about"
  weight = 4

[[main]]
  name = "Contact"
  pageRef = "contact"
  weight = 5
EOF
echo -e "  ${GREEN}✓${NC} menus.en.toml"

cat > "$CONFIG/menus.tr.toml" << 'EOF'
[[main]]
  name = "Ana Sayfa"
  pageRef = "/"
  weight = 1

[[main]]
  name = "Almanya"
  pageRef = "almanya"
  weight = 2

[[main]]
  name = "Yaşam"
  pageRef = "almanya/yasam"
  parent = "Almanya"
  weight = 1

[[main]]
  name = "Gezi"
  pageRef = "almanya/seyahat"
  parent = "Almanya"
  weight = 2

[[main]]
  name = "Expat Rehberleri"
  pageRef = "almanya/expat"
  parent = "Almanya"
  weight = 3

[[main]]
  name = "Seyahat"
  pageRef = "seyahat"
  weight = 3

[[main]]
  name = "Hakkımda"
  pageRef = "hakkimda"
  weight = 4

[[main]]
  name = "İletişim"
  pageRef = "iletisim"
  weight = 5
EOF
echo -e "  ${GREEN}✓${NC} menus.tr.toml"

cat > "$CONFIG/menus.de.toml" << 'EOF'
[[main]]
  name = "Startseite"
  pageRef = "/"
  weight = 1

[[main]]
  name = "Deutschland"
  pageRef = "deutschland"
  weight = 2

[[main]]
  name = "Leben"
  pageRef = "deutschland/leben"
  parent = "Deutschland"
  weight = 1

[[main]]
  name = "Reisen"
  pageRef = "deutschland/reisen"
  parent = "Deutschland"
  weight = 2

[[main]]
  name = "Expat-Ratgeber"
  pageRef = "deutschland/expat"
  parent = "Deutschland"
  weight = 3

[[main]]
  name = "Reisen"
  pageRef = "reisen"
  weight = 3

[[main]]
  name = "Über mich"
  pageRef = "ueber-mich"
  weight = 4

[[main]]
  name = "Kontakt"
  pageRef = "kontakt"
  weight = 5
EOF
echo -e "  ${GREEN}✓${NC} menus.de.toml"

echo ""

# =============================================================================
# STEP 7: Sonuç kontrolü
# =============================================================================
echo -e "${BLUE}🔍 STEP 7: Sonuç kontrolü...${NC}"
echo ""
echo "EN/germany:"
find "$CONTENT/en/germany" -name "*.md" | sed "s|$CONTENT/en/germany/||" | sort

echo ""
echo "TR/almanya:"
find "$CONTENT/tr/almanya" -name "*.md" | sed "s|$CONTENT/tr/almanya/||" | sort

echo ""
echo "DE/deutschland:"
find "$CONTENT/de/deutschland" -name "*.md" | sed "s|$CONTENT/de/deutschland/||" | sort

echo ""
echo "========================================="
echo -e "${GREEN}✅ Reorganizasyon tamamlandı!${NC}"
echo ""
echo "Sonraki adım — Hugo'yu test et:"
echo "  cd ~/Documents/sharehub && hugo server"
echo ""
echo "⚠️  Blowfish menü dropdown için params.toml'da"
echo "   showSubmenus = true olduğunu kontrol et."
echo "========================================="
