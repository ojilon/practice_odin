# How To Practice (READ THIS FIRST)

This is a long-term Odin dojo. You learn by writing code, managing memory deliberately, reading real systems and papers, and shipping small but real artifacts.

The journey is designed for **12–18 months**. The early months give you language + memory fluency; the later months turn that fluency into a GUI library, an editor, and a self-improving tool chain.

---

## 1. Core rules

### 1a. Entry point
There is a root `main.odin` (or small set of entry files) used as a **scratch runner**. You temporarily call into the package you are currently practicing. Reviewers ignore the scratch entry point.

### 1b. Memory first
Odin makes allocation explicit. From Phase 1 onward you are expected to:
- Know which allocator is in use (`context.allocator`, temp, arena, custom…)
- Prefer arenas and clear lifetime scopes where they fit
- Use the tracking allocator in debug builds to catch leaks and bad frees
- Document ownership for any non-trivial structure you design

### 1c. Who writes what
- Guides and scaffolds are written by assistants / future agents.
- **You** write all the actual Odin code.
- Do not paste large amounts of external code; study it and re-implement the ideas.

### 1d. Reuse
Later work builds on earlier work. A GUI widget that needs a dynamic list should prefer your list (or a clear comment that you deliberately chose the built-in for a reason). The same rule applies all the way up to the editor.

---

## 2. Folder layout

```
ROADMAP.md
HOW_TO_PRACTICE.md
BUILD_CHAIN.md
EXPLORATION.md
SCAFFOLD_FOR_FUTURE_AGENTS.md
PROGRESS.md
core_notes/                  # language & memory reference sheets
phase_01_core/               # language + memory (early full guides)
phase_02_ds/                 # data structures
phase_03_algo_papers/        # algorithms + short paper adventures
phase_04_core_rebuilds/      # selective re-implementations of core ideas
phase_05_tools/              # first real CLI tools
phase_06_systems/            # Win32, virtual memory, low-level
phase_07_gui/                # GUI library (major)
phase_08_editor/             # text editor (major)
phase_09_dogfood/            # internal tools + improvement loop
phase_10_product/            # extraction, polish, capstones
```

Each fully-specified exercise folder typically contains:
- `00_GUIDE.md` — why, steps, constraints, done-when
- `01_EXERCISES.md` — concrete tasks and required symbols
- `02_QUESTIONS.md` — run-and-answer or reflection questions
- `.odin` source files you create

---

## 3. Daily / weekly rhythm

- Most days: one focused folder or one clear sub-goal.
- Early on: heavy emphasis on understanding allocators and the tracking allocator.
- Weekly: one exploration activity (read `core:` source, a paper, or a small real project).
- At major milestones: ship something with a README.

---

## 4. What to create vs avoid

**Do**
- Create packages under the phase folders.
- Use explicit allocators and document ownership.
- Fill answer / reflection boxes in `02_QUESTIONS.md`.
- Later: create separate repositories for the GUI library and the editor.

**Avoid**
- Hiding allocations or relying on “it just works”.
- Large copy-paste from external projects.
- Skipping the memory-focused early phases.

---

## 5. How to run

Typical pattern:

```bash
odin run .
# or
odin build . -out:practice_odin.exe
```

For a specific package you are developing, import it from your scratch `main.odin` and call its demo / test procedures.

Use the tracking allocator in debug builds regularly:

```odin
when ODIN_DEBUG {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.allocator)
    context.allocator = mem.tracking_allocator(&track)
    defer {
        // report leaks / bad frees
        mem.tracking_allocator_destroy(&track)
    }
}
```

---

## 6. Done = verifiable + usable

A folder is done when:
1. The required procedures and types exist and behave correctly.
2. Memory behaviour is intentional (no unexplained leaks under the tracking allocator for the happy path).
3. Any reflection / answer boxes are filled.
4. Later work can import or clearly reuse the package.

Larger milestones (GUI, editor) are done when they meet the shippable definition in the roadmap and you can actually use them.

---

## 7. Long-term mindset

- Explicit memory is a feature, not a burden. Learn to love clear lifetimes.
- Study real `core:` code; it is unusually readable.
- Prefer a working simplified system you fully understand over a half-finished complex one.
- Once the editor exists, use it. That feedback loop is part of the design.
- Future agents will expand the later phases using the scaffolds already present.
