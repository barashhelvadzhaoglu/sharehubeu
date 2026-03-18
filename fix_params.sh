#!/bin/bash
# =============================================================================
# ShareHub - params.toml güncelleme scripti
# reorganize.sh'dan SONRA çalıştır
# Çalıştırma: cd ~/Documents/sharehub && bash fix_params.sh
# =============================================================================

BASE="$HOME/Documents/sharehub"
PARAMS="$BASE/config/_default/params.toml"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "⚙️  params.toml güncelleniyor..."
echo ""

# mainSections güncelle — tüm dillerdeki ana section'ları ekle
sed -i '' 's|mainSections = \["almanya", "seyahat"\]|mainSections = ["almanya", "seyahat", "germany", "travel", "deutschland", "reisen", "almanya/yasam", "almanya/seyahat", "almanya/expat", "germany/living", "germany/travel", "germany/expat", "deutschland/leben", "deutschland/reisen", "deutschland/expat"]|' "$PARAMS"

echo -e "${GREEN}✅ mainSections güncellendi${NC}"
echo ""

# showMoreLinkDest güncelle — ana sayfada "daha fazla" linki
sed -i '' 's|showMoreLinkDest = "almanya"|showMoreLinkDest = "almanya/seyahat"|' "$PARAMS"

echo -e "${GREEN}✅ showMoreLinkDest güncellendi${NC}"
echo ""

# Sonucu göster
echo "Güncel mainSections:"
grep "mainSections" "$PARAMS"
echo ""
echo "Güncel showMoreLinkDest:"
grep "showMoreLinkDest" "$PARAMS"
echo ""
echo "========================================="
echo -e "${GREEN}✅ params.toml güncellendi!${NC}"
echo ""
echo "Şimdi test et:"
echo "  hugo server --buildFuture"
echo "========================================="
