# Ralph Agent Instructions

You are building AgentFlow Builder - a visual drag-and-drop AI agent workflow designer.

## Your Location

You are in the `agentflow/` project directory. Create files here directly.

## Your Task

1. **Read** `ralph/spec.md` to see all iterations and their requirements
2. **Find** the first iteration that is NOT marked complete (still has `[ ]`)
3. **Implement** ONLY that one iteration - create or update `index.html`
4. **Test** using claude-in-chrome MCP:
   - Start a local HTTP server: `python3 -m http.server 8080` (run in background)
   - Open http://localhost:8080/index.html in Chrome (NOT file:/// - that won't work)
   - Follow EVERY test step listed under "Test with /chrome:" in spec.md for this iteration
   - Actually interact with the UI (drag nodes, click buttons, etc.)
   - Verify each specific behavior works as described
   - Stop the HTTP server when done testing
5. **Update** `ralph/spec.md` - change `[ ]` to `[x]` for the completed iteration
6. **STOP** - End your response immediately after step 5

═══════════════════════════════════════════════════════════
CRITICAL: ONE ITERATION ONLY - THIS IS MANDATORY
═══════════════════════════════════════════════════════════

You MUST complete exactly ONE iteration, then STOP.

- After implementing ONE iteration and updating spec.md, END YOUR RESPONSE
- Do NOT continue to the next iteration
- Do NOT "be efficient" by doing multiple iterations
- Do NOT say "let me continue with iteration 2"

WHY: The loop will AUTOMATICALLY spawn another iteration for you.
Each Ralph iteration = one task. This is BY DESIGN. Trust the process.

Your job is ONE iteration. The loop handles the rest. STOP after one.

═══════════════════════════════════════════════════════════

## Completion Signal

After updating spec.md, check the status of all iterations:
- If ANY iterations still show `[ ]` (incomplete) → End your response normally (do NOT output the promise tag)
- If ALL iterations show `[x]` (complete) → Output exactly: <promise>COMPLETE</promise>

## Tech Requirements

- Single `index.html` file with inline CSS and JavaScript
- Modern ES6+ JavaScript (no build tools, no npm)
- No external dependencies (no CDN links)
- Dark theme with professional styling
- All code in one file for simplicity

## Quality Check

Before marking an iteration complete:
- File must be valid HTML that opens in browser
- You MUST have tested with claude-in-chrome MCP
- You MUST have followed ALL test steps in spec.md for this iteration
- Each specific verification (drag, click, connect, etc.) must pass
