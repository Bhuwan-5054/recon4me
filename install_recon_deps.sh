#!/bin/bash

# ⚙️ Kali GPT Tool Installer
# Use: ./install_recon_deps.sh

echo "[+] Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "[+] Installing main tools from apt..."
sudo apt install -y subfinder amass assetfinder nuclei sqlmap gf golang unzip zip

echo "[+] Installing Go tools (httpx, gau, waybackurls, katana, dalfox)..."

export GO_PATH="$HOME/go"
export PATH="$GO_PATH/bin:$PATH"

go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/hahwul/dalfox/v2@latest

echo "[+] Installing GF patterns..."
mkdir -p ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf-patterns
cp ~/.gf-patterns/*.json ~/.gf/

echo "[✓] All tools installed and ready to go!"
