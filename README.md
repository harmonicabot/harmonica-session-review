# harmonica-session-review

A [Claude Code](https://claude.ai/code) skill that reviews [Harmonica](https://harmonica.chat) session transcripts to identify facilitation issues and suggest specific prompt improvements.

Harmonica sessions run on AI-facilitated 1-on-1 conversations. The facilitator's prompt is the product — small wording changes shift engagement, drop-off, and cross-pollination quality. This skill closes the loop: pull the transcripts, find what consistently broke, and propose concrete prompt fixes.

## Prerequisites

This skill requires the [harmonica-mcp](https://github.com/harmonicabot/harmonica-mcp) server for `get_session`, `get_responses`, `search_sessions`, and `update_session`.

To install:

1. **Get a Harmonica account** — [Sign up free](https://app.harmonica.chat) if you don't have one.
2. **Generate an API key** — [Profile](https://app.harmonica.chat/profile) > API Keys > Generate API Key. Copy the `hm_live_...` key.
3. **Install the MCP server** (replace with your actual key):
   ```
   claude mcp add-json harmonica '{"command":"npx","args":["-y","harmonica-mcp"],"env":{"HARMONICA_API_KEY":"hm_live_..."}}' -s user
   ```
4. Restart Claude Code.

## Installation

### Quick install (bash)

```bash
curl -fsSL https://raw.githubusercontent.com/harmonicabot/harmonica-session-review/master/install.sh | bash
```

### Quick install (PowerShell)

```powershell
irm https://raw.githubusercontent.com/harmonicabot/harmonica-session-review/master/install.ps1 | iex
```

### Manual installation

Copy `SKILL.md` to `~/.claude/skills/harmonica-session-review/SKILL.md`.

## Usage

The skill activates automatically when you ask Claude Code to review a Harmonica session:

```
review the "Q1 product retro" session
look at what went wrong in the brainstorming session yesterday
analyze the facilitation quality on session abc123
```

You can also invoke it directly:

```
use the harmonica-session-review skill on "Q1 product retro"
```

## What it does

1. Resolves the session by ID, topic search, or list-and-pick
2. Pulls all participant transcripts (filters to participants with 3+ messages)
3. Analyzes each transcript across structure, engagement, cross-pollination, edge cases, and goal alignment
4. Aggregates patterns that appear in 2+ transcripts
5. Proposes concrete prompt fixes for each issue, with evidence
6. Offers to apply prompt changes via `update_session` and open Linear issues for systemic problems

## Output shape

Every finding ties back to specific transcript evidence and produces an actionable change. No descriptive-only critiques — every issue gets a suggested fix.

## See also

- **[harmonica-mcp](https://github.com/harmonicabot/harmonica-mcp)** — MCP server with full Harmonica API access
- **[harmonica-chat](https://github.com/harmonicabot/harmonica-chat)** — Slash command for designing, creating, and managing sessions. Has a lighter built-in `review` mode that defers to this skill for the full analysis.
- **[Harmonica docs](https://help.harmonica.chat)** — Platform documentation

## License

MIT
