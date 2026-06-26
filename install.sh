#!/bin/bash
# ===========================================
# Aider Installer for Termux
# ===========================================
# Run this script in Termux to install Aider
# ===========================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

INSTALL_FLAG="$HOME/.aider_termux_installed"

echo "🤖 Aider Installer for Termux"
echo "================================"

# Check if already installed
if [ -f "$INSTALL_FLAG" ]; then
    echo ""
    echo -e "${GREEN}✅ Aider is already installed!${NC}"
    echo ""
    echo "To change API key, edit ~/.bashrc"
    echo ""
    echo "🚀 To start:"
    echo "  source ~/.bashrc"
    echo "  aider"
    exit 0
fi

# Step 1: Update Termux packages
echo ""
echo -e "${YELLOW}[1/7] Updating Termux packages...${NC}"
pkg update && pkg upgrade

# Step 2: Install required packages
echo ""
echo -e "${YELLOW}[2/7] Installing required packages...${NC}"
pkg install python git bc make cmake clang

# Step 3: Verify Python installation
echo ""
echo -e "${YELLOW}[3/7] Verifying Python...${NC}"
echo "Found: $(python --version)"
echo "✅ Python ready!"

# Step 4: Install build tools
echo ""
echo -e "${YELLOW}[4/7] Installing build tools...${NC}"
pip install setuptools wheel

# Step 5: Install compatible dependencies
echo ""
echo -e "${YELLOW}[5/7] Installing dependencies...${NC}"
pip install "numpy>=2.0.0" "aiohttp>=3.9.0" "requests>=2.31.0" "urllib3>=2.0.0"

# Step 6: Install Aider with Google AI support
echo ""
echo -e "${YELLOW}[6/7] Installing Aider Chat...${NC}"
pip install aider-chat --no-deps
pip install GitPython prompt-toolkit Pygments rich tqdm configargparse PyYAML networkx diskcache pytest tiktoken google-generativeai

# Step 7: Setup Google AI API Key
echo ""
echo -e "${YELLOW}[7/7] Setting up Google AI Studio...${NC}"

echo ""
echo -e "${CYAN}🤖 Google AI Studio Setup${NC}"
echo ""
echo "Get your free API key at: https://aistudio.google.com/app/apikey"
echo ""

read -p "Paste your Google AI Studio API key: " api_key

if [ -n "$api_key" ]; then
    grep -v "AIDER_MODEL\|GOOGLE_API_KEY" ~/.bashrc > ~/.bashrc.tmp
    echo "" >> ~/.bashrc.tmp
    echo "# Google AI Studio API Key for Aider" >> ~/.bashrc.tmp
    echo "export GOOGLE_API_KEY=\"$api_key\"" >> ~/.bashrc.tmp
    echo "export AIDER_MODEL=google/gemini-2.5-flash" >> ~/.bashrc.tmp
    mv ~/.bashrc.tmp ~/.bashrc
    
    echo ""
    echo -e "${GREEN}✅ Google AI API key saved!${NC}"
else
    echo ""
    echo -e "${YELLOW}⏭️  No key entered. Run 'bash install.sh' later to configure.${NC}"
fi

# Mark as installed
touch "$INSTALL_FLAG"

# Final message
echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "🚀 To start:"
echo ""
echo "  source ~/.bashrc"
echo "  aider"
echo ""
echo "Happy coding! 🚀"