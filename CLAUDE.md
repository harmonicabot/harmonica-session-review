# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

harmonica-session-review is a Claude Code skill that reviews [Harmonica](https://harmonica.chat) session transcripts to identify facilitation issues and suggest specific prompt improvements. It's distributed as a single Markdown file (`SKILL.md`) that users install to `~/.claude/skills/harmonica-session-review/`.

The skill requires the [harmonica-mcp](https://github.com/harmonicabot/harmonica-mcp) server for `get_session`, `get_responses`, `search_sessions`, and `update_session`.

## Repository Structure

- `SKILL.md` — The skill itself. This is the entire product. YAML frontmatter (`name:`, `description:`) controls when Claude Code activates it.
- `install.sh` / `install.ps1` — One-line installers that download `SKILL.md` to `~/.claude/skills/harmonica-session-review/`
- `README.md` — User-facing docs (installation, usage, what it does)

## How the Skill Works

Triggers on user requests to review, analyze, or critique a Harmonica session. The skill walks through:
1. Resolve session (by ID, topic search, or list-and-pick)
2. Pull all transcripts via `get_responses`, filter to participants with 3+ user messages
3. Analyze each transcript across 5 dimensions (structure, engagement, cross-pollination, edge cases, goal alignment)
4. Aggregate patterns appearing in 2+ transcripts
5. Propose concrete prompt fixes with transcript evidence
6. Offer to apply via `update_session` or open Linear issues

## Key Design Decisions

**Evidence over opinion** — every finding cites a specific transcript moment. No "the facilitator could be warmer" without quoting where it wasn't.

**Patterns over incidents** — single occurrences are notes, 2+ occurrences are findings. Filters out noise.

**Actionable over descriptive** — every issue produces a concrete prompt-fix suggestion or a Linear-issue proposal for systemic problems. No findings without fixes.

**Prompt changes are cheap** — suggest them freely. The facilitator's behavior IS the user experience; small wording shifts compound.

## Development Workflow

No build step, linter, or test suite. The product is a single Markdown file interpreted by Claude Code at runtime.

**To test changes**: Copy `SKILL.md` to `~/.claude/skills/harmonica-session-review/SKILL.md` and trigger the skill in Claude Code by asking to review a Harmonica session.

**To release**: Push to `master`. Users re-running the install command get the latest.

## Related Codebases

- **[harmonica-mcp](https://github.com/harmonicabot/harmonica-mcp)** — MCP server with `get_session`, `get_responses`, `search_sessions`, `list_sessions`, `update_session` tools. This skill calls these.
- **[harmonica-chat](https://github.com/harmonicabot/harmonica-chat)** — Sister slash command for designing and managing sessions. Has a lighter `review` lifecycle mode that explicitly defers to this skill for full analysis.
- **harmonica-web-app** — Main platform. Facilitation prompt pipeline in `src/lib/defaultPrompts.ts` and `src/app/api/builder/route.ts` — useful context when proposing prompt changes.
