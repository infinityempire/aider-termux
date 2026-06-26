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

# Step 6: Install Aider
echo ""
echo -e "${YELLOW}[6/7] Installing Aider Chat...${NC}"
pip install aider-chat --no-deps
pip install GitPython prompt-toolkit Pygments rich tqdm configargparse PyYAML networkx diskcache pytest tiktoken openai

# Step 7: Setup API Key
echo ""
echo -e "${YELLOW}[7/7] Setting up API Key...${NC}"

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║            🔑 Choose Your AI Provider                  ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  1) 🤖 Google AI Studio (Gemini) - FREE TIER AVAILABLE"
echo "  2) 🔷 OpenAI (GPT-4o)"
echo "  3) 🟤 Anthropic (Claude)"
echo "  4) ⏭️  Skip for now"
echo ""

read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo -e "${BLUE}📝 Google AI Studio Setup${NC}"
        echo ""
        echo "Get your free API key at: https://aistudio.google.com/app/apikey"
        echo ""
        read -p "Paste your API key: " api_key
        
        if [ -n "$api_key" ]; then
            # Remove old entries and add new ones
            grep -v "AIDER_MODEL\|GOOGLE_API_KEY" ~/.bashrc > ~/.bashrc.tmp
            echo "" >> ~/.bashrc.tmp
            echo "# Google AI Studio API Key for Aider" >> ~/.bashrc.tmp
            echo "export GOOGLE_API_KEY=\"$api_key\"" >> ~/.bashrc.tmp
            echo "export AIDER_MODEL=google/gemini-2.5-flash" >> ~/.bashrc.tmp
            mv ~/.bashrc.tmp ~/.bashrc
            
            echo ""
            echo -e "${GREEN}✅ API key saved!${NC}"
        fi
        ;;
    2)
        echo ""
        echo -e "${BLUE}📝 OpenAI Setup${NC}"
        echo ""
        echo "Get your API key at: https://platform.openai.com/api-keys"
        echo ""
        read -p "Paste your API key: " api_key
        
        if [ -n "$api_key" ]; then
            grep -v "OPENAI_API_KEY" ~/.bashrc > ~/.bashrc.tmp
            echo "" >> ~/.bashrc.tmp
            echo "export OPENAI_API_KEY=\"$api_key\"" >> ~/.bashrc.tmp
            mv ~/.bashrc.tmp ~/.bashrc
            
            echo ""
            echo -e "${GREEN}✅ API key saved!${NC}"
        fi
        ;;
    3)
        echo ""
        echo -e "${BLUE}📝 Anthropic Setup${NC}"
        echo ""
        echo "Get your API key at: https://console.anthropic.com/settings/keys"
        echo ""
        read -p "Paste your API key: " api_key
        
        if [ -n "$api_key" ]; then
            grep -v "ANTHROPIC_API_KEY\|AIDER_MODEL" ~/.bashrc > ~/.bashrc.tmp
            echo "" >> ~/.bashrc.tmp
            echo "export ANTHROPIC_API_KEY=\"$api_key\"" >> ~/.bashrc.tmp
            echo "export AIDER_MODEL=claude-sonnet-4-20250514" >> ~/.bashrc.tmp
            mv ~/.bashrc.tmp ~/.bashrc
            
            echo ""
            echo -e "${GREEN}✅ API key saved!${NC}"
        fi
        ;;
    4)
        echo ""
        echo -e "${YELLOW}⏭️  Skipped. Run 'bash install.sh' later to configure.${NC}"
        ;;
esac

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