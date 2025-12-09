#!/bin/bash

# Script to remove loaders from all HTML files
cd /Users/mac/Downloads/bluechipcasino.io/bluechipcasino.io

# Create the CSS fix in a temp file
cat > /tmp/loader_fix.txt << 'EOF'
  <!-- Fix: Hide all loaders and show content immediately -->
  <style>
    .Preloader--splash__P4cvW,
    .Preloader--loader__3JZ79,
    .Preloader--background__9V_ct,
    [class*="loader"],
    [class*="Loader"],
    [class*="loading"],
    [class*="Loading"],
    [class*="preloader"],
    .Modal-Loader,
    ._loader_1t1h2_64,
    ._loader_huhg7_48,
    ._loader_6qbcd_32,
    ._loaderItem_6qbcd_39,
    ._loading_jjh0g_42,
    ._loader_mw5dy_41,
    ._loaderOverlay_sca5w_52,
    ._loader_sca5w_52,
    .ChangeActiveWallet-List-Loader,
    .LazyLottie--preloader__i9oBP {
      display: none !important;
      opacity: 0 !important;
      visibility: hidden !important;
    }
    
    /* Ensure main content is visible */
    #__next,
    .Main-Container,
    body > div {
      display: block !important;
      opacity: 1 !important;
      visibility: visible !important;
    }
  </style>
  <noscript>
EOF

count=0
skipped=0

# Find all HTML files and process them
find . -name "*.html" -type f | while read -r file; do
    # Skip if already fixed
    if grep -q "Fix: Hide all loaders" "$file"; then
        ((skipped++))
        continue
    fi
    
    # Check if file has <body tag
    if grep -q "<body" "$file"; then
        # Use perl for better multiline handling
        perl -i -pe 'BEGIN{undef $/;} s|<noscript>|`cat /tmp/loader_fix.txt`|smg' "$file"
        echo "Fixed: $file"
        ((count++))
    fi
done

echo ""
echo "====================================="
echo "Processing complete!"
echo "Fixed: $count files"
echo "Skipped (already fixed): $skipped files"
echo "====================================="

# Cleanup
rm -f /tmp/loader_fix.txt
