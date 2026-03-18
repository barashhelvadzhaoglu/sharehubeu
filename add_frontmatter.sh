#!/bin/bash
# =============================================================================
# ShareHub - Front Matter Ekleme Scripti
# Sadece front matter'ı eksik olan dosyalara ekler
# Mevcut tarihlere dokunmaz
# Çalıştırma: bash add_frontmatter.sh
# Konum: ~/Documents/sharehub/
# =============================================================================

CONTENT="./content"
BASE="$HOME/Documents/sharehub/content"

# Renkler
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "📝 ShareHub Front Matter Ekleme Scripti"
echo "========================================"
echo "Mevcut son tarih: 2026-03-27"
echo "Yeni yazılar: 2026-03-28'den itibaren"
echo ""

# Front matter ekleme fonksiyonu
# Kullanım: add_fm DOSYA "Title" TARIH "translationKey" "description" "tag1,tag2"
add_fm() {
  local file="$1"
  local title="$2"
  local date="$3"
  local tkey="$4"
  local desc="$5"
  local tags="$6"

  local fullpath="$BASE/en/germany/$file"

  if [ ! -f "$fullpath" ]; then
    echo -e "${YELLOW}  ⚠ Bulunamadı: $file${NC}"
    return
  fi

  if head -1 "$fullpath" | grep -q "^---"; then
    echo -e "${YELLOW}  ⏭ Zaten var: $file${NC}"
    return
  fi

  # Tags'i array formatına çevir
  local tags_formatted=""
  IFS=',' read -ra TAG_ARRAY <<< "$tags"
  for tag in "${TAG_ARRAY[@]}"; do
    tags_formatted="$tags_formatted  - \"$(echo $tag | xargs)\"\n"
  done

  local tmp=$(mktemp)
  printf -- "---\ntitle: \"%s\"\ndate: %sT08:00:00+01:00\ndraft: false\ndescription: \"%s\"\ntranslationKey: \"%s\"\ntags:\n%s---\n\n" \
    "$title" "$date" "$desc" "$tkey" "$(printf "$tags_formatted")" > "$tmp"
  cat "$fullpath" >> "$tmp"
  mv "$tmp" "$fullpath"
  echo -e "${GREEN}  ✓ $file → $date${NC}"
}

echo "--- Turkey vs Germany Serisi (Living) ---"
echo ""

# Mevcut son tarih 2026-03-27, yeni yazılar 28'den başlıyor
# Turkey vs Germany serisi: 28 Mart - 19 Nisan

add_fm "trust-in-germany.md" \
  "Trust as a Way of Life: What Germany Taught Me About Believing in People" \
  "2026-03-28" "trust-in-germany" \
  "Small details in daily German life that reveal a deep culture of civic trust." \
  "Germany,Expat Life,German Culture,Munich,Society"

add_fm "why-i-moved-countries.md" \
  "Why I Left Turkey: The Decision That Changed Everything" \
  "2026-03-29" "why-i-moved-countries" \
  "A personal account of weighing family, freedom, and the future before moving abroad." \
  "Expat Life,Moving Abroad,Turkey,Germany,Family"

add_fm "turkey-vs-germany.md" \
  "Turkey vs Germany: An Honest Comparison After Making the Move" \
  "2026-03-30" "turkey-vs-germany-overview" \
  "Not a travel guide. Not a rant. Just what I have actually experienced living in both countries." \
  "Turkey,Germany,Expat Life,Comparison,Munich"

add_fm "06-health-system-turkey-vs-germany.md" \
  "Health System: Turkey vs Germany" \
  "2026-03-31" "tvg-health-system" \
  "From walking into any hospital to waiting weeks for a specialist — here is what actually changed when I moved." \
  "Germany,Turkey,Healthcare,GKV,Expat Life"

add_fm "07-shopping-turkey-vs-germany.md" \
  "Shopping and Daily Errands: Turkey vs Germany" \
  "2026-04-01" "tvg-shopping" \
  "Sunday everything is closed. Yes, really. Here is how to adapt and what you might actually prefer." \
  "Germany,Turkey,Shopping,Daily Life,Munich"

add_fm "08-food-turkey-vs-germany.md" \
  "Food and Eating Out: Turkey vs Germany" \
  "2026-04-02" "tvg-food" \
  "Turkish cuisine is world-famous for a reason. But German food culture has surprises of its own." \
  "Germany,Turkey,Food,Munich,Biergarten"

add_fm "09-housing-turkey-vs-germany.md" \
  "Housing and Renting: Turkey vs Germany" \
  "2026-04-03" "tvg-housing" \
  "Finding a flat in Munich is one of the hardest things I have done. Here is the full picture." \
  "Germany,Turkey,Housing,Renting,Munich"

add_fm "10-social-life-turkey-vs-germany.md" \
  "Social Life and Making Friends: Turkey vs Germany" \
  "2026-04-04" "tvg-social-life" \
  "Germans are cold — is it true? It is more complicated than that." \
  "Germany,Turkey,Social Life,Expat Life,Munich"

add_fm "11-language-barrier-turkey-vs-germany.md" \
  "The Language Barrier: Turkey vs Germany" \
  "2026-04-05" "tvg-language" \
  "You can survive in Munich with English. But surviving and living are different things." \
  "Germany,Turkish Expat,German Language,Expat Life,Munich"

add_fm "12-turkish-muslim-identity-germany.md" \
  "Being Turkish and Muslim in Germany: What It Is Actually Like" \
  "2026-04-06" "tvg-identity" \
  "The headlines do not tell the full story. Here is my day-to-day experience." \
  "Germany,Turkish Expat,Muslim,Identity,Munich"

add_fm "13-elderly-care-turkey-vs-germany.md" \
  "Elderly Care and Family Structure: Turkey vs Germany" \
  "2026-04-07" "tvg-elderly-care" \
  "In Turkey, family takes care of family. In Germany, the state steps in. Neither model is perfect." \
  "Germany,Turkey,Family,Elderly Care,Expat Life"

add_fm "14-cars-traffic-turkey-vs-germany.md" \
  "Cars and Traffic Culture: Turkey vs Germany" \
  "2026-04-08" "tvg-traffic" \
  "The Autobahn has no speed limit. Turkish drivers have no limits either. But the difference is everything." \
  "Germany,Turkey,Traffic,Autobahn,Munich"

add_fm "15-work-life-turkey-vs-germany.md" \
  "Work Life and Work-Life Balance: Turkey vs Germany" \
  "2026-04-09" "tvg-work-life" \
  "In Turkey, you work hard and stay late. In Germany, you leave on time and nobody apologises for it." \
  "Germany,Turkey,Work Life Balance,Expat Life,Munich"

add_fm "16-kita-childcare-turkey-vs-germany.md" \
  "Childcare and the Kita System: Turkey vs Germany" \
  "2026-04-10" "tvg-kita" \
  "Finding a Kita spot in Munich is harder than finding a flat. But the system, when you are in it, is remarkable." \
  "Germany,Turkey,Childcare,Kita,Munich"

add_fm "17-primary-school-turkey-vs-germany.md" \
  "Primary School: Turkey vs Germany" \
  "2026-04-11" "tvg-school" \
  "No homework until age 10. I had to read that twice." \
  "Germany,Turkey,Education,School,Expat Parenting"

add_fm "18-bicultural-kids-turkey-vs-germany.md" \
  "Growing Up Between Two Cultures: Turkey vs Germany" \
  "2026-04-12" "tvg-bicultural" \
  "My child speaks three languages and belongs fully to neither country. I am not sure that is a problem." \
  "Germany,Turkey,Bicultural,Expat Family,Munich"

add_fm "19-climate-seasons-turkey-vs-germany.md" \
  "Climate and Seasons: Turkey vs Germany" \
  "2026-04-13" "tvg-climate" \
  "I knew German winters would be grey. I did not know how grey. Or how beautiful the summers would be." \
  "Germany,Turkey,Climate,Munich,Bavaria"

add_fm "20-quality-of-life-final-verdict.md" \
  "Quality of Life and Happiness: The Final Verdict" \
  "2026-04-14" "tvg-quality-of-life" \
  "After everything — is Germany better? The honest answer is more complicated than yes or no." \
  "Germany,Turkey,Quality of Life,Expat Life,Munich"

echo ""
echo "--- Avrupa Serisi (Expat) ---"
echo ""

add_fm "eu-series-01-netherlands.md" \
  "Working and Living in the Netherlands: What I Learned Before Moving" \
  "2026-04-15" "eu-netherlands" \
  "I applied for jobs there, got a sponsorship offer, and researched everything. Here is what nobody tells you." \
  "Netherlands,Expat Life,Europe,30 Percent Ruling,Moving Abroad"

add_fm "eu-series-02-luxembourg.md" \
  "Working and Living in Luxembourg: Europe's Best Kept Secret?" \
  "2026-04-16" "eu-luxembourg" \
  "Free public transport. Low taxes. A country where half the population are immigrants. Here is the full picture." \
  "Luxembourg,Expat Life,Europe,Tax,Moving Abroad"

add_fm "eu-series-03-comparison-why-germany.md" \
  "Netherlands vs Luxembourg vs Germany: Why I Chose Germany" \
  "2026-04-17" "eu-comparison" \
  "I researched all three seriously. Here is the side-by-side comparison and the honest reasons behind my final decision." \
  "Germany,Netherlands,Luxembourg,Expat Life,Moving Abroad"

add_fm "eu-series-04-job-seeker-visa-germany-EN.md" \
  "Germany Job Seeker Visa: My Personal Experience and Everything You Need to Know" \
  "2026-04-18" "eu-job-seeker-visa" \
  "I researched it, applied, received a response a year later. Here is exactly what happened and what you should do today." \
  "Germany,Visa,Job Seeker Visa,Moving to Germany,Expat Life"

echo ""
echo "========================================"
echo -e "${GREEN}✅ Tamamlandı!${NC}"
echo ""
echo "Son yayın tarihi: 2026-04-18"
echo "Toplam yeni yazı: 22"
echo ""
echo "Kontrol için:"
echo "  grep -r '^date:' ~/Documents/sharehub/content/en/germany/ | sort"
echo ""
