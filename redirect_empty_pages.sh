#!/bin/bash

# Script to update links to empty pages to redirect to index.html
# Empty pages: deposit.html, sports-betting-rules.html, privacy-policy.html, 
# velisports.html, awards-and-certificates.html, casino-bonus-terms-conditions.html

echo "Updating links to empty pages..."

# Get list of all HTML files
find . -name "*.html" -type f ! -name "deposit.html" ! -name "sports-betting-rules.html" ! -name "privacy-policy.html" ! -name "velisports.html" ! -name "awards-and-certificates.html" ! -name "casino-bonus-terms-conditions.html" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.bak"
    
    # Replace links to empty pages with index.html
    sed -i '' 's|href="deposit\.html"|href="index.html"|g' "$file"
    sed -i '' 's|href="sports-betting-rules\.html"|href="index.html"|g' "$file"
    sed -i '' 's|href="privacy-policy\.html"|href="index.html"|g' "$file"
    sed -i '' 's|href="velisports\.html"|href="index.html"|g' "$file"
    sed -i '' 's|href="awards-and-certificates\.html"|href="index.html"|g' "$file"
    sed -i '' 's|href="casino-bonus-terms-conditions\.html"|href="index.html"|g' "$file"
done

echo "Done! All links to empty pages now redirect to index.html"
echo "Backup files created with .bak extension"
