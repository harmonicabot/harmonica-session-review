#!/bin/bash
# Install harmonica-session-review for Claude Code

set -e

REPO_URL="https://raw.githubusercontent.com/harmonicabot/harmonica-session-review/master"
CLAUDE_DIR="$HOME/.claude"
SKILL_DIR="$CLAUDE_DIR/skills/harmonica-session-review"

echo "Installing harmonica-session-review..."

# Create directories
mkdir -p "$SKILL_DIR"

# Download skill file
curl -fsSL "$REPO_URL/SKILL.md" -o "$SKILL_DIR/SKILL.md"
echo "Installed SKILL.md -> $SKILL_DIR/"

echo ""
echo "Installation complete!"
echo ""
echo "harmonica-session-review requires the harmonica-mcp server."
echo "See https://github.com/harmonicabot/harmonica-mcp for setup."
echo ""
echo "Trigger the skill in Claude Code with: \"review the <session topic> session\""
