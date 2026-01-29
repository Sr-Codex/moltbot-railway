#!/bin/bash
set -e

echo "🚀 Starting Moltbot on Railway..."

# Log environment variables (without sensitive values)
echo "Environment check:"
echo "  - OPENAI_API_KEY: ${OPENAI_API_KEY:0:10}..."
echo "  - TELEGRAM_BOT_TOKEN: ${TELEGRAM_BOT_TOKEN:0:10}..."

# Create .clawbot directory if it doesn't exist
mkdir -p ~/.clawbot

# Check if setup is needed
if [ ! -f ~/.clawbot/moltbot.json ]; then
    echo "✨ First time setup..."
    # Create a basic config
    cat > ~/.clawbot/moltbot.json <<EOF
{
  "workspaceId": "$(uuidgen)",
  "openAIKey": "$OPENAI_API_KEY",
  "telegramBotToken": "$TELEGRAM_BOT_TOKEN"
}
EOF
    echo "✅ Configuration created"
fi

# Start the gateway which keeps the container alive
echo "🌐 Starting Moltbot Gateway..."
exec moltbot gateway --port 18789
