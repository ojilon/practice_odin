# Scaffold for Future Agents

This file tells any future agent how to expand the later phases of `practice_odin`.

The overall project goal is stated in `ROADMAP.md`. Keep that goal in mind: the learner is building a coherent, reusable stack that culminates in a GUI library and a text editor used to improve its own ecosystem, with strong early emphasis on explicit memory management and study of real systems/papers.

---

## What a complete exercise folder looks like

```
phase_XX_name/NN_shortname/
  00_GUIDE.md          # why, simple→complex steps, constraints, done-when
  01_EXERCISES.md      # concrete tasks, required symbols, allocator expectations
  02_QUESTIONS.md      # reflection / run-and-answer questions
  (learner creates the .odin files)
```

Tone should match the existing early guides: direct, practical, no solution code, explicit about memory and reuse.

Shared dojo systems (use them, don't reinvent them):
- `PRACTICE_LOOPS.md` — kata / allocator-torture / benchmark / reading / bug-journal / review loops. New phases should name which loops they trigger.
- `REVIEW_CHECKLIST.md` — the per-folder definition of done. Every GUIDE's "Done when" must be checkable against it.
- `common/dojo_debug` — tracking-allocator session wrapper. Guides should point learners at it instead of re-explaining tracking setup.
- `tools/verify_dojo.py` — structural check (each `NN_*` folder has the three markdown files, GUIDEs state Done-when). Run it after expanding a phase.
- `RESOURCES.md`, `BEST_PRACTICES.md` — curated sources + living patterns. New phases add 1–3 entries, not link dumps.

Quality bar for exercises (all phases):
- Difficulty tiers inside `01_EXERCISES.md`: Must (proves the concept) / Stretch (natural extension) / Spike (optional deep cut). Mark them.
- Required symbols named where reuse matters (`buf_push`, `map_get`, …) so later phases can import without guessing.
- Allocator expectations stated per owning type (param at make vs documented `context.allocator` capture + stored allocator + destroy proc).
- At least one deliberate broken-then-fixed trap per ownership-critical folder (dangling slice, blank-on-delete, use-after-clear, stale view after grow). Broken stays labeled, out of the happy path.
- At least one measurement or allocator-swap comparison from Phase 2 onward (machine + flags + N recorded).
- `02_QUESTIONS.md` boxes demand observed output (numbers, reports, tallies), not theory.

---

## How to expand a phase

1. Read the phase description in `ROADMAP.md` and the relevant section of `BUILD_CHAIN.md`.
2. Create the folder structure and the three markdown files.
3. In the GUIDE, list concrete resources (Odin core source, papers, Win32 docs, etc.).
4. In the EXERCISES, define a minimal viable set of types/procedures that prove the concept, plus stretch goals.
5. Always require explicit allocator thinking where allocations occur.
6. Keep scope shippable: a working demo beats an unfinished perfect design.

---

## Phase-specific guidance

### Phase 1 (remaining folders)
- DONE (fully scaffolded): 02, 03, 05, 06, 07, 08 + core_notes 02/03/05/06/07. Keep them in sync with the notes index.
- Every memory-related exercise must force use of the tracking allocator in debug and discussion of ownership.

### Phase 2 — Data structures
- DONE (scaffolded): `phase_02_ds/` 01–08 with README, guides, exercises, questions. Capstone 08 (torture + bench + winners table) gates Phase 3 imports.
- Each structure takes an allocator (or documents that it uses context.allocator).
- Provide clear ownership and free/destroy procedures.
- Prefer data-oriented layouts where natural.

### Phase 3 — Algorithms + paper adventures
- Keep paper adventures short and fun.
- Require a short “what I learned / what I simplified” note.

### Phase 4 — Core rebuilds
- Selective and educational, not a full reimplementation of core.
- Always compare to the real `core:` version.

### Phase 5 — Tools
- Real CLI tools that compose earlier packages.
- Good place to solidify logging, config, and argument handling.

### Phase 6 — Systems / Win32
- Practical window + message loop is the main deliverable that enables the GUI phase.
- Virtual memory and custom allocators are supporting skills.

### Phase 7 — GUI library
- This is a major milestone. Structure it as a multi-week progression (window → drawing → input → widgets → layout → theme).
- Point at immediate-mode literature and existing small toolkits for ideas.
- End product should be extractable to its own repository.

### Phase 8 — Editor
- Must consume the GUI library.
- Text buffer strategy is a research + implementation task (gap buffer / piece table / rope).
- Syntax highlighting and file I/O are required.
- Shippable = usable for real editing of Odin code.

### Phase 9 — Dogfooding
- Emphasize the feedback loop: use the editor to improve the editor and tools.
- Internal tools should feel useful, not ceremonial.

### Phase 10+
- Extraction, documentation, best-practices collection, and learner-chosen capstones.

---

## Style rules

- Speak directly to the learner.
- Never write the solution implementation in the guides.
- Always surface allocator and ownership questions.
- Always give a concrete “Done when” that includes a runnable demonstration.
- Prefer primary sources (Odin core, original papers, classic references).

When you finish expanding a phase, update `ROADMAP.md` and add corresponding checks to any verifier notes if they exist.
