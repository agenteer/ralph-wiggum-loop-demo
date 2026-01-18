#!/bin/bash
# Ralph Loop - Bash Implementation for AgentFlow Builder
# Usage: ./ralph/run.sh [model] [max_iterations]
#        ./ralph/run.sh [max_iterations]  (for backward compatibility)

set -e

# Handle backward compatibility: if first arg is a number, treat it as iterations
if [[ "$1" =~ ^[0-9]+$ ]]; then
    MODEL=haiku
    MAX_ITERATIONS=${1:-5}
else
    MODEL=${1:-haiku}
    MAX_ITERATIONS=${2:-5}
fi
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Ensure temp directory exists
mkdir -p /tmp/claude

# Cleanup function for graceful exit
cleanup() {
    echo ""
    echo "Cleaning up..."
    rm -f /tmp/claude/ralph-iteration-*.txt 2>/dev/null || true
    pkill -f "python3 -m http.server 8080" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

echo "═══════════════════════════════════════════════════════════"
echo "Ralph Loop (Bash) - AgentFlow Builder"
echo "Max iterations: $MAX_ITERATIONS"
echo "Model: $MODEL"
echo "Project: $PROJECT_DIR"
echo "═══════════════════════════════════════════════════════════"

cd "$PROJECT_DIR"

# Show initial status
echo ""
echo "Initial status:"
grep "^\- \[" ralph/spec.md || true
echo ""

for i in $(seq 1 $MAX_ITERATIONS); do
    echo "═══════════════════════════════════════════════════════"
    echo " Ralph Iteration $i of $MAX_ITERATIONS"
    echo "═══════════════════════════════════════════════════════"
    echo ""

    # Kill any lingering HTTP server from previous iteration
    pkill -f "python3 -m http.server 8080" 2>/dev/null || true
    sleep 1  # Give port time to release

    # Temp file for output (allows streaming AND capture)
    TEMP_OUTPUT="/tmp/claude/ralph-iteration-$i.txt"

    # Spawn fresh Claude instance with Chrome MCP enabled
    # --print --verbose --output-format stream-json: Required combo for streaming
    # jq: Parse JSON stream to show tool calls and text in real-time
    cat "$SCRIPT_DIR/prompt.md" | claude --print --verbose --output-format stream-json --chrome --model "$MODEL" --dangerously-skip-permissions 2>&1 | tee "$TEMP_OUTPUT" | jq -r --unbuffered '
      if .type == "assistant" then
        .message.content[]? |
        if .type == "tool_use" then "🔧 " + .name
        elif .type == "text" then .text
        else empty end
      elif .type == "result" then "✅ Iteration complete"
      else empty end
    ' 2>/dev/null || true

    # Kill HTTP server after iteration (agent may have started one)
    pkill -f "python3 -m http.server 8080" 2>/dev/null || true

    echo ""
    echo "--- Progress after iteration $i ---"
    grep "^\- \[" ralph/spec.md || true
    echo ""

    # Check for completion signal (exact match for promise tag)
    if grep -q "<promise>COMPLETE</promise>" "$TEMP_OUTPUT"; then
        echo "═══════════════════════════════════════════════════════"
        echo "✅ AgentFlow Builder COMPLETE!"
        echo "Finished at iteration $i of $MAX_ITERATIONS"
        echo "═══════════════════════════════════════════════════════"
        echo ""
        echo "Open index.html to see the result:"
        echo "  open index.html"
        echo ""
        exit 0
    fi

    echo "--- Spawning next iteration... ---"
    sleep 2
done

echo ""
echo "═══════════════════════════════════════════════════════"
echo "⚠️ Reached max iterations ($MAX_ITERATIONS) without completing."
echo "Check ralph/spec.md for progress:"
grep "^\- \[" ralph/spec.md || true
echo "═══════════════════════════════════════════════════════"
exit 1
