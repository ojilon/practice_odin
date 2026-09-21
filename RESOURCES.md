# Resources — Curated, Small, Enough

Prefer primary sources. Read one fully over skimming five. Add entries with a one-line "why" as you discover them.

## Odin language & core
- Odin overview + docs — `https://odin-lang.org/docs/overview/` — language tour, start here.
- Odin core library docs — `https://pkg.odin-lang.org/` — authoritative `core:` reference.
- `core:mem` source (local Odin install: `odin root` → `core/mem/`) — allocators, arenas, tracking; read the actual code.
- `core:container` source — compare your Phase 2 structures against the real ones.
- Ginger Bill's writings / talks on Odin and allocation strategy — framing for arena/temp/scratch thinking.

## Data structures & algorithms (Phase 2–3 fuel)
- "Open Data Structures" (Morin, free online: `https://opendatastructures.org/`) — clear pseudocode + analysis for lists, hash tables, heaps, trees.
- `https://www.cs.usfca.edu/~galles/visualization/` — algorithm visualizations for building intuition before coding.
- Your local `core:container/*` + `core:sort` source — what production Odin actually does.

## Systems / Win32 (Phase 6–7 fuel)
- Microsoft Learn: "Get started with Win32" + "Windows API index" — message loop, window creation, GDI basics.
- `core:sys/windows` source — how Odin binds the API you will call.
- `core:mem/virtual` source — virtual-memory primitives behind custom allocators.

## GUI & editor (Phase 7–8 fuel)
- Casey Muratori, "Immediate-Mode Graphical User Interfaces" (2005, free PDF) — the core mental model for a simple GUI.
- Dear ImGui: `https://github.com/ocornut/imgui` — read design notes/docs, not to copy but to understand per-frame UI trade-offs.
- Gap buffer / piece table / rope write-ups (any of: Wikipedia overviews → original papers → editor blogs) — buffer-strategy research for Phase 8.

## Formats & papers (Phase 3 / Q-FORMAT fuel)
- PDF Reference (ISO 32000 subsets) + `core:encoding/*` source — object/xref reading adventures.
- WAV/RIFF spec summaries + ISO BMFF (MP4) box overviews — container-demux intuition.
- OpenSimplex / value-noise explanations — short noise adventures.

## How to use this file
- Before each phase, pick 1–2 entries, read them, and log 5–10 lines per `EXPLORATION.md`.
- When a guide names a resource, it means *this* list or the guide's explicit link — not a random tutorial.
- If a link dies, replace it with the closest primary source and note the swap.
