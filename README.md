# recon4me

`recon4me` is a full-featured bug bounty reconnaissance automation script built for ethical hackers and security researchers. It combines the power of tools like `subfinder`, `amass`, `httpx`, `nuclei`, `dalfox`, and more into a single beast-mode command.

---

## 🚀 Features
- Subdomain enumeration
- Live domain probing
- URL and JavaScript file extraction
- Passive and active endpoint discovery
- XSS, SQLi, and CVE-based vulnerability scanning
- Auto zip report packaging

---

## ⚙️ Requirements
Make sure the following tools are installed:

```bash
sudo apt install -y subfinder amass assetfinder nuclei sqlmap gf golang unzip zip

# Add this to your shell config (bash/zsh) if not already set:
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc && source ~/.bashrc
```

Then install these Go-based tools:
```bash
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/hahwul/dalfox/v2@latest
```

GF Patterns:
```bash
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf-patterns
mkdir -p ~/.gf && cp ~/.gf-patterns/*.json ~/.gf/
```

---

## 📦 Installation
Clone the repo and run the installer:

```bash
git clone https://github.com/Bhuwan-5054/recon4me.git
cd recon4me
chmod +x recon4me install.sh
./install.sh
```

This will copy the script globally as a command you can run from anywhere:
```bash
recon4me
```

---

## 🧠 Usage

```bash
recon4me
```
Then enter your target domain (e.g., `example.com`) and let the tool work its magic.

Results will be saved in a `recon_targetdomain/` folder, and zipped for convenience.

---

## 📜 Legal
Only use this tool on domains you have **explicit permission** to test. Unauthorized scanning is illegal.

---

## 🐉 Author
Kali GPT - https://chat.openai.com/g/g-fmLSgXrKN-kali-gpt
