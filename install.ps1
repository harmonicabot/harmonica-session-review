# Install harmonica-session-review for Claude Code

$ErrorActionPreference = "Stop"

$RepoUrl = "https://raw.githubusercontent.com/harmonicabot/harmonica-session-review/master"
$ClaudeDir = "$env:USERPROFILE\.claude"
$SkillDir = "$ClaudeDir\skills\harmonica-session-review"

Write-Host "Installing harmonica-session-review..."

# Create directories
New-Item -ItemType Directory -Force -Path $SkillDir | Out-Null

# Download skill file
Invoke-WebRequest -Uri "$RepoUrl/SKILL.md" -OutFile "$SkillDir\SKILL.md"
Write-Host "Installed SKILL.md -> $SkillDir\"

Write-Host ""
Write-Host "Installation complete!"
Write-Host ""
Write-Host "harmonica-session-review requires the harmonica-mcp server."
Write-Host "See https://github.com/harmonicabot/harmonica-mcp for setup."
Write-Host ""
Write-Host "Trigger the skill in Claude Code with: 'review the <session topic> session'"
