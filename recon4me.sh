#!/bin/bash

# ╔══════════════════════════════════════╗
# ║ 🔍 Tool: recon4me                    ║
# ║ 🧠 By: Kali GPT (for ethical use)    ║
# ║ 🚀 Purpose: Bug Bounty Recon Beast   ║
# ║ 📅 Created: 2025                     ║
# ╚══════════════════════════════════════╝

read -p "🔍 Enter target domain (example.com): " domain
mkdir -p recon_$domain && cd recon_$domain

echo "[+] 🔎 Subdomain enumeration..."
subfinder -d $domain -silent -o subfinder.txt
assetfinder --subs-only $domain | tee assetfinder.txt
amass enum -passive -d $domain -o amass.txt
cat *.txt | sort -u > all_subdomains.txt

echo "[+] 🌐 Checking for live domains..."
httpx -l all_subdomains.txt -title -tech-detect -status-code -o live_subdomains.txt -silent

echo "[+] 🌍 Gathering URLs (Wayback + GAU)..."
cat all_subdomains.txt | waybackurls > wayback.txt
cat all_subdomains.txt | gau > gau.txt
cat wayback.txt gau.txt | sort -u > all_urls.txt

mkdir js
cat all_urls.txt | grep \".js\" | httpx -mc 200 -silent -o js/js_files.txt

mkdir -p katana
katana -list live_subdomains.txt -silent -o katana/endpoints.txt

echo \"[+] 🚀 Running Nuclei on live domains...\"
mkdir -p nuclei
nuclei -l live_subdomains.txt -o nuclei/nuclei_scan.txt -silent

echo \"[+] 🧬 Hunting XSS params with GF and Dalfox...\"
mkdir -p xss
cat all_urls.txt | gf xss | sort -u > xss/xss_params.txt
dalfox file xss/xss_params.txt --skip-bav -o xss/dalfox_results.txt

mkdir -p sqli
cat all_urls.txt | gf sqli | sort -u > sqli/sqli_candidates.txt

echo \"[!] 💉 Testing SQLi URLs with sqlmap (non-interactive)\"
while read url; do
    sqlmap -u \"$url\" --batch --level=2 --risk=2 --random-agent --output-dir=sqli/sqlmap_out --crawl=1
done < sqli/sqli_candidates.txt

echo \"[✓] All scans completed for $domain. Results stored in recon_$domain/\"
ls -R . > scan_summary.txt

echo \"[+] Zipping results...\"
cd .. && zip -r recon_$domain.zip recon_$domain

echo \"[🔥] recon4me finished. Use ethically and wisely. 🐉\"
exit 0
