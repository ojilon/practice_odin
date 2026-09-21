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
- Finish any incomplete core language + memory folders.
- Every memory-related exercise must force use of the tracking allocator in debug and discussion of ownership.

### Phase 2 — Data structures
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
