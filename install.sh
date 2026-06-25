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
NC='\033[0m' # No Color

# Step 1: Update Termux packages
echo ""
echo -e "${YELLOW}[1/5] Updating Termux packages...${NC}"
pkg update -y && pkg upgrade -y

# Step 2: Install required packages
echo ""
echo -e "${YELLOW}[2/5] Installing required packages...${NC}"
pkg install python git -y

# Step 3: Verify Python installation
echo ""
echo -e "${YELLOW}[3/5] Verifying Python installation...${NC}"
PYTHON_VERSION=$(python --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
echo "Found Python $PYTHON_VERSION"

if [ "$(echo "$PYTHON_VERSION < 3.9" | bc)" -eq 1 ]; then
    echo -e "${RED}⚠️  Python 3.9+ required. Current: $PYTHON_VERSION${NC}"
    echo "Try: pkg install python"
    exit 1
fi

# Step 4: Upgrade pip
echo ""
echo -e "${YELLOW}[4/5] Upgrading pip...${NC}"
pip install --upgrade pip -y

# Step 5: Install Aider
echo ""
echo -e "${YELLOW}[5/5] Installing Aider Chat...${NC}"
pip install aider-chat

# Verify installation
echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "Type 'aider' to start coding with AI"
echo ""
echo "Example usage:"
echo "  aider                    # Start an interactive session"
echo "  aider main.py            # Edit a file"
echo "  aider --opus             # Use Claude Opus model"
echo ""
echo -e "Get your API key at: https://platform.openai.com/api-keys"
echo "Or set up Anthropic: https://console.anthropic.com/"
echo ""
echo "Happy coding! 🚀"