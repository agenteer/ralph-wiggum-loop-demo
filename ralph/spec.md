# AgentFlow Builder - Requirements

A visual drag-and-drop interface for designing AI agent workflows.

## Status

- [ ] Iteration 1: Canvas
- [ ] Iteration 2: Connections
- [ ] Iteration 3: Execution Animation

---

## Iteration 1: Canvas

**Build:**
- Single `index.html` file with inline CSS and JS
- Dark theme (#1a1a2e background, modern aesthetic)
- Left sidebar (200px) with draggable node types: Agent, Tool, Input, Output
- Main canvas area for dropping nodes
- Nodes are colored boxes (Agent=purple, Tool=blue, Input=green, Output=orange)
- Drag a node type from sidebar → drops onto canvas at cursor position
- Each dropped node shows its type name and has small connection ports (circles on edges)

**Test with /chrome:** (Start `python3 -m http.server 8080` first, use http://localhost:8080)
1. Open http://localhost:8080/index.html in Chrome
2. See dark themed interface with sidebar on left
3. Drag "Agent" from sidebar onto canvas
4. Verify: purple "Agent" node appears where you dropped it
5. Drag "Tool" node, verify it appears separately

---

## Iteration 2: Connections

**Build:**
- Each node has output port (right side) and input port (left side)
- Click and drag from output port → creates temporary line following cursor
- Release on another node's input port → creates permanent bezier curve connection
- Connection lines MUST be clearly visible against dark background:
  - Use bright colors (white, cyan #00ffff, or bright gradient)
  - Stroke width: 3-4px minimum
  - Do NOT use dark/gray colors that blend into background
- Click any node on canvas → shows config panel on right side
- Config panel has: Name field, Description textarea, close button
- Editing config updates the node's displayed name

**Test with /chrome:** (Use http://localhost:8080/index.html)
1. Create Input, Agent, and Output nodes on canvas (drag from sidebar)
2. ACTUALLY drag from Input's output port (right circle) to Agent's input port (left circle) - you must perform this mouse drag action
3. STOP and look at the screenshot: Do you see a curved line between Input and Agent? If NO line visible → FIX THE CODE, do not proceed
4. ACTUALLY drag from Agent's output port to Output's input port
5. STOP and verify: You must see TWO visible curved lines connecting Input → Agent → Output. If not visible → FIX THE CODE
6. Click the Agent node, verify config panel appears
7. ONLY mark iteration complete if you can visually confirm connection lines exist in screenshot

---

## Iteration 3: Execution Animation

**Build:**
- Header bar with "AgentFlow Builder" title and "Run Flow" button
- Find nodes with no inputs (entry points) to start execution
- When "Run Flow" clicked:
  - Animated dot/pulse travels along each connection
  - Nodes glow/highlight when execution "reaches" them
  - Small status badge shows: "waiting" → "running" → "done"
  - Animation follows the connection graph in topological order
- Add visual polish: subtle shadows, smooth transitions, hover effects on nodes
- Reset button to clear animation state

**Test with /chrome:** (Use http://localhost:8080/index.html)
1. Create a flow: Input → Agent → Tool → Output
2. Click "Run Flow" button
3. Verify: Input node glows first, shows "running"
4. Verify: animated pulse travels along connection to Agent
5. Verify: Agent glows, then pulse continues to Tool, then Output
6. Verify: all nodes show "done" when complete
7. Overall feel should be polished and professional
