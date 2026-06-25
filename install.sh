#!/bin/bash
# ===========================================
# Aider Installer for Termux
# ===========================================
# Run this script in Termux to install Aider
# ===========================================

set -e

echo "🤖 Aider Installer for Termux"
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Step 1: Update Termux packages
echo ""
echo -e "${YELLOW}[1/6] Updating Termux packages...${NC}"
pkg update && pkg upgrade

# Step 2: Install required packages
echo ""
echo -e "${YELLOW}[2/6] Installing required packages...${NC}"
pkg install python git bc make cmake clang

# Step 3: Verify Python installation
echo ""
echo -e "${YELLOW}[3/6] Verifying Python installation...${NC}"
PYTHON_VERSION=$(python --version 2>&1)
echo "Found: $PYTHON_VERSION"
echo "✅ Python ready!"

# Step 4: Skip pip upgrade (Termux manages pip)
echo ""
echo -e "${YELLOW}[4/6] Skipping pip upgrade (managed by Termux)...${NC}"
echo "✅ pip is ready!"

# Step 5: Install build tools for Python packages
echo ""
echo -e "${YELLOW}[5/7] Installing Python build tools...${NC}"
pip install setuptools wheel

# Step 6: Install NumPy 2.x (Python 3.13 compatible)
echo ""
echo -e "${YELLOW}[6/7] Installing NumPy (Python 3.13 compatible)...${NC}"
pip install numpy>=2.0.0

# Step 7: Install Aider
echo ""
echo -e "${YELLOW}[7/7] Installing Aider Chat...${NC}"
pip install aider-chat

# Step 8: Setup API Key
echo ""
echo -e "${YELLOW}[8/8] Setting up API Key...${NC}"

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║            🔑 Choose Your AI Provider                  ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  1) 🤖 Google AI Studio (Gemini) - FREE TIER AVAILABLE"
echo "  2) 🔷 OpenAI (GPT-4o)"
echo "  3) 🟤 Anthropic (Claude)"
echo "  4) ⏭️  Skip for now (configure later)"
echo ""

read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo -e "${BLUE}📝 Google AI Studio Setup${NC}"
        echo ""
        echo "Get your free API key at: https://aistudio.google.com/app/apikey"
        echo ""
        read -p "Paste your Google AI Studio API key: " api_key
        
        if [ -n "$api_key" ]; then
            # Create or update bashrc with the API key
            echo "" >> ~/.bashrc
            echo "# Google AI Studio API Key for Aider" >> ~/.bashrc
            echo "export GOOGLE_API_KEY=\"$api_key\"" >> ~/.bashrc
            echo "export AIDER_MODEL=google/gemini-2.5-flash" >> ~/.bashrc
            
            # Also set for current session
            export GOOGLE_API_KEY="$api_key"
            export AIDER_MODEL=google/gemini-2.5-flash
            
            echo ""
            echo -e "${GREEN}✅ Google AI Studio API key saved!${NC}"
            echo "Model set to: google/gemini-2.5-flash"
        fi
        ;;
    2)
        echo ""
        echo -e "${BLUE}📝 OpenAI Setup${NC}"
        echo ""
        echo "Get your API key at: https://platform.openai.com/api-keys"
        echo ""
        read -p "Paste your OpenAI API key (sk-...): " api_key
        
        if [ -n "$api_key" ]; then
            echo "" >> ~/.bashrc
            echo "# OpenAI API Key for Aider" >> ~/.bashrc
            echo "export OPENAI_API_KEY=\"$api_key\"" >> ~/.bashrc
            export OPENAI_API_KEY="$api_key"
            
            echo ""
            echo -e "${GREEN}✅ OpenAI API key saved!${NC}"
            echo "Default model: gpt-4o"
        fi
        ;;
    3)
        echo ""
        echo -e "${BLUE}📝 Anthropic Setup${NC}"
        echo ""
        echo "Get your API key at: https://console.anthropic.com/settings/keys"
        echo ""
        read -p "Paste your Anthropic API key (sk-ant-...): " api_key
        
        if [ -n "$api_key" ]; then
            echo "" >> ~/.bashrc
            echo "# Anthropic API Key for Aider" >> ~/.bashrc
            echo "export ANTHROPIC_API_KEY=\"$api_key\"" >> ~/.bashrc
            echo "export AIDER_MODEL=claude-sonnet-4-20250514" >> ~/.bashrc
            export ANTHROPIC_API_KEY="$api_key"
            export AIDER_MODEL=claude-sonnet-4-20250514
            
            echo ""
            echo -e "${GREEN}✅ Anthropic API key saved!${NC}"
            echo "Model set to: claude-sonnet-4-20250514"
        fi
        ;;
    4)
        echo ""
        echo -e "${YELLOW}⏭️  Skipped. Configure API key later by editing ~/.bashrc${NC}"
        ;;
    *)
        echo ""
        echo -e "${RED}⚠️  Invalid choice. Configure API key later.${NC}"
        ;;
esac

# Verify installation
echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "🚀 To start coding with AI:"
echo ""
echo "  source ~/.bashrc          # Load your API key"
echo "  aider                     # Start session"
echo "  aider your_file.py        # Edit a file"
echo ""
echo "📚 Docs: https://aider.chat/docs/"
echo ""
echo "Happy coding! 🚀"