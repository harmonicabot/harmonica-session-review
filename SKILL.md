---
name: harmonica-session-review
description: Review a Harmonica session's transcripts to identify facilitation issues and suggest prompt improvements. Use when user wants to analyze how a session went, improve facilitation quality, or process participant feedback.
---

# Harmonica Session Review — Facilitation Quality Analysis

Analyze participant transcripts from a Harmonica session to identify facilitation issues, cross-pollination effectiveness, and suggest specific prompt improvements.

## Arguments

- `$ARGUMENTS` — session ID, topic search text, or empty (will list recent sessions)

## Process

### 1. Find the Session

- If session ID provided, use `get_session` to fetch it
- If topic text provided, use `search_sessions` to find it
- If empty, use `list_sessions` with `limit: 10` and ask the user to pick

### 2. Pull All Transcripts

Call `get_responses` for the session. For each participant with 3+ user messages (completed or substantial conversations), extract the full transcript.

Skip participants with only 1-2 messages (just joined, didn't engage).

### 3. Analyze Each Transcript

For each transcript, evaluate these dimensions:

**Structure adherence:**
- Did the facilitator follow the prompt's question flow?
- Did it ask ONE question at a time?
- Were messages kept short (2-3 sentences)?

**Engagement quality:**
- Where did the participant give short/vague answers? What preceded those moments?
- Where did the participant engage deeply? What prompted that?
- Did the participant drop off before completing? At what point?

**Cross-pollination (if enabled):**
- Did cross-pollination trigger? How many times?
- Was the timing appropriate (not too early, not interrupting a deep answer)?
- Were insights relevant to what the participant was discussing?
- Were insights concise or too long/formal?
- Did the participant engage with the insight or ignore it?

**Edge case handling:**
- "Not sure" / vague answers — did the facilitator help or just rephrase?
- Meta questions ("how many people?", "who else is here?") — handled honestly?
- Session ending — clean exit or awkward continuation?
- Fourth wall breaks — did the facilitator reference "this group" or session mechanics?

**Goal alignment:**
- Did the conversation serve the session's stated goal?
- Did the facilitator steer toward the goal or drift?

### 4. Aggregate Patterns

After reviewing all transcripts, identify:

**Common failure modes** — issues that appeared in 2+ transcripts
**Common success patterns** — what consistently worked well
**Cross-pollination effectiveness** — overall hit rate, quality, timing
**Drop-off points** — where participants commonly disengage
**Missing capabilities** — things the facilitator should do but can't

### 5. Suggest Prompt Improvements

Every pattern found in step 4 should produce a concrete prompt fix. The connection between "participants kept doing X" and "change the prompt to handle X" must be explicit.

Examples of pattern → fix:
- "4/7 participants asked 'what group?'" → remove "this group" from question, say "people working on AI and democracy" instead
- "3/7 participants said 'not sure' to the same question" → rephrase the question, or add a rule to offer other participants' answers as a starting point
- "5/7 participants gave 1-word answers to question 3" → the question is too abstract, make it concrete
- "Cross-pollination insight was ignored in 3/4 cases" → insights are too long or poorly timed, adjust generation prompt

For each issue, propose a specific change:

```
## Issue: [description]
Evidence: [N/M transcripts]
Example: [participant] said "[quote]" in response to "[facilitator question]"

Current prompt: "[exact text causing the problem]"
Suggested change: "[new text]"
Reason: [why this fixes it, based on the transcript evidence]
```

Every Example must include both the literal participant quote AND the facilitator question that prompted it. No hand-waving with "participant X seemed disengaged at step 3" — quote the exchange.

Changes should be either:
- **Prompt rule additions** — new rules in the ### Rules section
- **Question rewrites** — modify specific questions in the ### Flow section
- **Systemic fixes** — needs code changes (create Linear issue with project)

### 6. Present Findings

Format the output as:

```markdown
## Session Review: "[topic]"

**Participants reviewed:** N of M (filtered to 3+ messages)
**Cross-pollination:** triggered N times across M participants
**Session goal:** [goal]

### What Worked
- [pattern]: seen in N/M transcripts

### Issues Found
1. **[issue]** (N/M transcripts)
   - Example: [participant] said "[quote]" in response to "[facilitator question]"
   - Suggested fix: [specific change]

### Prompt Changes
[Present each change with before/after if applicable]

### Linear Issues
[List any systemic issues that need code changes, with suggested project]
```

### 7. Apply Changes

Ask the user:
- "Apply these prompt changes to the session?" → use `update_session` to update the prompt
- "Create Linear issues for systemic problems?" → create issues with proper project assignment
- "Save findings for future reference?" → save to `docs/session-reviews/` in the relevant project

## Key Principles

- **Evidence over opinion** — every finding must reference a specific transcript moment
- **Patterns over incidents** — single occurrences are notes, repeated issues are findings
- **Actionable over descriptive** — every issue needs a concrete fix suggestion
- **Prompt changes are cheap** — suggest them freely. Code changes need Linear issues.
- **The facilitator is the product** — its behavior IS the user experience. Small improvements matter.

## Future Direction

This skill is manual — someone runs it after a session. The long-term vision is an automated feedback loop: after every N participants, the system analyzes transcripts, detects repeated failure patterns, and suggests prompt updates.
