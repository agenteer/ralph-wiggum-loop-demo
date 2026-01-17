# AgentFlow Builder - Ralph Wiggum Loop Demo

A demo showing [Ralph Wiggum Loop](https://ghuntley.com/ralph/) in action. Watch an AI agent build a visual workflow designer through autonomous iteration.

## What This Demo Shows

Ralph Loop lets your agent work for hours while you sleep. This demo builds **AgentFlow Builder** - a drag-and-drop workflow designer - in 3 iterations:

1. **Canvas** - Dark-themed canvas with draggable nodes
2. **Connections** - Bezier curves connecting nodes
3. **Execution Animation** - Animated pulse through the workflow

The agent builds everything from scratch. You just watch.

## Prerequisites

- [Claude Code CLI](https://code.claude.com/docs/en/overview) (subscription or API key)
- Chrome (for visual testing via [Chrome integration](https://code.claude.com/docs/en/chrome))

**For Plugin Approach only:**
- [ralph-loop plugin](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop)

```bash
/plugin marketplace add anthropics/claude-plugins-official
/plugin install ralph-loop
# Restart Claude Code after installing
```

**For Bash Approach:** No plugin needed—just Claude CLI.

## Running the Demo

### Option 1: Plugin Approach

```bash
# Reset to clean state
./reset.sh

# Start Claude with Chrome MCP
claude --model haiku --chrome

# Run the loop
/ralph-loop:ralph-loop "Read ralph/prompt.md for your full instructions. Follow them exactly." --completion-promise "COMPLETE" --max-iterations 5
```

### Option 2: Bash Approach

```bash
# Reset to clean state
./reset.sh

# Run the bash loop (max 5 iterations)
./ralph/run.sh 5
```

### View the Result

After completion, open the generated app:

```bash
python3 -m http.server 8080
# Then open http://localhost:8080/index.html
```

## How It Works

1. **`ralph/spec.md`** - Defines what to build with checkboxes for each iteration
2. **`ralph/prompt.md`** - Instructions that enforce one-task-per-iteration
3. **`reset.sh`** - Resets everything for a fresh run
4. **`ralph/run.sh`** - Bash loop that spawns fresh Claude instances

Each iteration:
- Reads spec.md to find the first unchecked task
- Implements that one task
- Tests with Chrome MCP
- Marks the checkbox complete
- Stops (the loop spawns the next iteration)

## Key Insight

The loop doesn't force iteration—it enables it. Without resistance to persist against (tests to pass, complexity to work through), the agent just completes in one pass.

This demo is designed with clear iteration boundaries and visual testing at each step, showing the actual Ralph loops in action.

## Related

- [Ralph Wiggum Loop article that explains this demo in detail](https://agenteer.com/blog/ralph-wiggum-loop-what-it-is-and-why-you-might-be-using-it-wrong) - Full explanation
- [Geoffrey Huntley's original Ralph](https://ghuntley.com/ralph/)
- [Ryan Carson's PRD-based Ralph](https://github.com/snarktank/ralph)

## License

MIT
