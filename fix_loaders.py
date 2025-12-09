#!/usr/bin/env python3
import os
import re
from pathlib import Path

# CSS to inject
CSS_FIX = '''
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
'''

def fix_html_file(filepath):
    """Add CSS fix to hide loaders in HTML file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Skip if already fixed
        if 'Fix: Hide all loaders' in content:
            return 'already_fixed'
        
        # Find <body> tag and insert CSS right after it
        body_tag = '<body>'
        if body_tag in content:
            # Insert CSS right after <body>
            content = content.replace(body_tag, body_tag + CSS_FIX, 1)
            
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return 'fixed'
        else:
            return 'no_body_tag'
            
    except Exception as e:
        return f'error: {str(e)}'

def main():
    base_dir = Path('/Users/mac/Downloads/bluechipcasino.io/bluechipcasino.io')
    
    fixed_count = 0
    already_fixed_count = 0
    error_count = 0
    no_tag_count = 0
    
    # Find all HTML files
    html_files = list(base_dir.rglob('*.html'))
    total_files = len(html_files)
    
    print(f"Found {total_files} HTML files to process...")
    print()
    
    for i, filepath in enumerate(html_files, 1):
        result = fix_html_file(filepath)
        
        if result == 'fixed':
            fixed_count += 1
            if fixed_count <= 20 or i % 100 == 0:  # Show first 20 and every 100th
                print(f"[{i}/{total_files}] Fixed: {filepath.relative_to(base_dir)}")
        elif result == 'already_fixed':
            already_fixed_count += 1
        elif result == 'no_noscript_tag':
            no_tag_count += 1
        else:
            error_count += 1
            print(f"[{i}/{total_files}] Error in {filepath.relative_to(base_dir)}: {result}")
    
    print()
    print("=" * 60)
    print("Processing Complete!")
    print("=" * 60)
    print(f"Total files processed: {total_files}")
    print(f"Fixed: {fixed_count}")
    print(f"Already fixed: {already_fixed_count}")
    print(f"No <body> tag found: {no_tag_count}")
    print(f"Errors: {error_count}")
    print("=" * 60)

if __name__ == '__main__':
    main()
