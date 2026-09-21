# Shared helpers (`common/`)

Small packages you may import from any phase. Keep this directory tiny — only code that is genuinely reused.

| Package | Import | Purpose |
|---------|--------|---------|
| `dojo_debug` | `common/dojo_debug` | tracking-allocator session wrapper + leak report for demos and(Device) tests |

Rules:
- `common/` code must itself be tracking-clean and must never hide allocations (every helper documents its allocator).
- Don't put exercise solutions here. Helpers only: debug, bench timing, tiny test asserts.
- If a helper grows phase-specific logic, move it into that phase's package instead.
