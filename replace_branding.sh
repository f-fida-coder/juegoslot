#!/bin/bash

# Script to replace BlueChip branding with Juuega Slots branding
# This script replaces all occurrences of "bluechip" text and logo images

echo "Starting branding replacement..."
echo "================================"

# Directory to search
TARGET_DIR="/Users/mac/Downloads/bluechipcasino.io/bluechipcasino.io"

cd "$TARGET_DIR"

# Count files before replacement
total_html_files=$(find . -type f -name "*.html" | wc -l)
echo "Total HTML files found: $total_html_files"
echo ""

# 1. Replace all logo image URLs with logo.png
echo "Step 1: Replacing logo images..."
find . -type f -name "*.html" -exec sed -i '' \
    -e 's|https://cms-cdn\.bc-bn\.net/bluechip-cms/main_logo_light_[a-zA-Z0-9_]*\.svg|logo.png|g' \
    -e 's|/bluechip-cms/main_logo_light_[a-zA-Z0-9_]*\.svg|logo.png|g' \
    -e 's|main_logo_light_[a-zA-Z0-9_]*\.svg|logo.png|g' \
    -e 's|static/media/main-logo-light\.[a-zA-Z0-9]*\.svg|logo.png|g' {} \;

echo "✓ Logo images replaced"
echo ""

# 2. Replace alt text for logos
echo "Step 2: Replacing logo alt text..."
find . -type f -name "*.html" -exec sed -i '' \
    -e 's|alt="main_logo_light_[a-zA-Z0-9_]*"|alt="juuega slots logo"|g' {} \;

echo "✓ Logo alt text replaced"
echo ""

# 3. Replace all text occurrences of "bluechip" with "juuega slots"
echo "Step 3: Replacing 'bluechip' text with 'juuega slots'..."

# Case variations
find . -type f -name "*.html" -exec sed -i '' \
    -e 's/Bluechip Casino/Juuega Slots Casino/g' \
    -e 's/Bluechip Online Casino/Juuega Slots Online Casino/g' \
    -e 's/Bluechip/Juuega Slots/g' \
    -e 's/bluechip/juuega slots/g' \
    -e 's/BLUECHIP/JUUEGA SLOTS/g' \
    -e 's/BlueChip/Juuega Slots/g' {} \;

echo "✓ Text 'bluechip' replaced with 'juuega slots'"
echo ""

# 4. Replace bluechip in URLs and API references (keep technical ones intact)
echo "Step 4: Updating domain references..."
find . -type f -name "*.html" -exec sed -i '' \
    -e 's|bluechipcasino\.io|juuegaslots.io|g' \
    -e 's|bluechip\.io|juuegaslots.io|g' {} \;

echo "✓ Domain references updated"
echo ""

# 5. Count replacements made
echo "================================"
echo "Replacement Summary:"
echo "================================"

logo_count=$(grep -r "logo.png" . --include="*.html" 2>/dev/null | wc -l)
juuega_count=$(grep -ri "juuega slots" . --include="*.html" 2>/dev/null | wc -l)

echo "Files with logo.png: $(grep -rl "logo.png" . --include="*.html" 2>/dev/null | wc -l)"
echo "Total logo.png occurrences: $logo_count"
echo "Total 'juuega slots' occurrences: $juuega_count"
echo ""
echo "✓ Branding replacement completed successfully!"
echo ""
echo "NOTE: Make sure to place your logo.png file in the root directory"
echo "      or update the path as needed."
