# 🤖 Aider on Termux - Installer

Install the **Aider** AI coding agent on your Android phone via Termux!

## 🚀 Quick Install

Open Termux and run:

```bash
# Clone this repo
git clone https://github.com/infinityempire/aider-termux.git
cd aider-termux

# Run the installer
bash install.sh
```

## 🔑 API Key Setup

The installer will prompt you to choose your AI provider:

| Provider | Model | Free Tier |
|----------|-------|-----------|
| 🤖 **Google AI Studio** | Gemini 2.5 Flash | ✅ Yes! |
| 🔷 OpenAI | GPT-4o | ❌ No |
| 🟤 Anthropic | Claude Sonnet | ❌ No |

### Get Your Free Google AI Key:
1. Go to: https://aistudio.google.com/app/apikey
2. Click "Create API Key"
3. Copy and paste during installation

## 📋 What Gets Installed

- Python 3.11+
- pip
- Aider Chat (with all dependencies)
- Git (if not present)

## ⚙️ Requirements

- **Termux** app from F-Droid (recommended) or Google Play
- Android 7.0 or higher
- ~500MB free space

## 🔧 What is Aider?

Aider is an AI pair programming tool that lets you chat with GPT-4o/Claude and edit code in your local git repository. It's awesome for coding on mobile!

## 📱 Usage

After installation, use Aider like this:

```bash
# Load your API key
source ~/.bashrc

# Start coding with AI
aider your-file.py

# Or initialize a new project
aider --init
```

## 🆘 Troubleshooting

**If pip fails:**
```bash
pip install --upgrade pip
pip install aider-chat
```

**If Python version issues:**
```bash
python --version  # Make sure it's 3.9+
```

**To change API key later:**
```bash
nano ~/.bashrc
# Edit the GOOGLE_API_KEY line
source ~/.bashrc
```

## 📄 License

MIT

---

*Created with ❤️ by OpenHands*