# Roadmap — 12 to 18 Month Odin Journey

**Project goal (read this carefully — future agents need this context):**

Build lasting skill in Odin by creating a coherent stack of tools that progressively depend on each other. The end state is not a single perfect program; it is a small ecosystem you understand completely:

- Solid command of language core + explicit memory management
- Your own small collections of data structures and utilities
- Comfortable use (and selective re-implementation) of `core:` packages
- A usable GUI library
- A text editor built on that GUI
- Internal tools that the editor itself helps you improve
- The habit of reading papers and real systems and turning them into short, shippable experiments
- Practical experience parsing real document and media formats (PDF subsets, XML, simple audio/video containers, etc.)

Dogfooding is intentional: once the editor exists, you use it to work on the editor, the GUI library, and the earlier tools.

Times assume ~1–2 focused hours most days. Adjust freely.

---

## High-level arc

| Months | Phase | Focus |
|--------|-------|-------|
| 0–2    | 0–3   | Language core, memory, basic data structures, first tools |
| 2–4    | 4–5   | Deeper core usage, algorithms, short paper adventures, first format parsers |
| 4–6    | 6     | Systems, Win32, low-level facilities |
| 6–8    | 7     | GUI library (the big intermediate goal) |
| 8–11   | 8     | Text editor on your GUI + earlier tools |
| 11–14  | 9     | Internal tools + dogfooding loop |
| 14–18  | 10+   | Productization, more papers, format tools, capstones |

---

## Phase 0 — Setup & Mindset (Day 0)

- [ ] Read `HOW_TO_PRACTICE.md`
- [ ] Read `EXPLORATION.md`
- [ ] Read `BUILD_CHAIN.md`
- [ ] Read `SCAFFOLD_FOR_FUTURE_AGENTS.md`
- [ ] Install / confirm Odin works (`odin version`)
- [ ] Make a minimal `main.odin` that prints and compiles
- [ ] Skim `core_notes/00_INDEX.md`

---

## Phase 1 — Language Core + Memory (Weeks 1–4)

Memory and allocators appear early because they are central to Odin.

| # | Folder | Focus |
|---|--------|-------|
| 01 | `phase_01_core/01_hello_and_basics` | packages, procedures, basic types, printing |
| 02 | `phase_01_core/02_structs_and_procs` | structs, distinct types, procedure overloading, parametric |
| 03 | `phase_01_core/03_slices_and_arrays` | fixed arrays, slices, dynamic arrays, `append` |
| 04 | `phase_01_core/04_memory_intro` | `context.allocator`, `new`/`free`/`delete`, temp allocator, tracking allocator |
| 05 | `phase_01_core/05_arenas_and_custom` | arena allocators, custom allocator interface, ownership thinking |
| 06 | `phase_01_core/06_maps_and_strings` | maps, string vs string types, builders |
| 07 | `phase_01_core/07_error_style` | or_return, error unions, defer patterns |
| 08 | `phase_01_core/08_packages_and_context` | multi-file packages, context system deeper, private |

Full guides exist for the first few; later ones in this phase are scaffolded.
Phase 1 is now fully scaffolded: 02 (structs/procs/polymorphism), 03 (slices/arrays/ownership), 05 (arenas + custom allocator), 06 (maps/strings/key ownership), 07 (error style + defer), 08 (multi-package capstone). Core notes 02/03/05/06/07 cover each folder; see also `PRACTICE_LOOPS.md`, `REVIEW_CHECKLIST.md`, `common/dojo_debug`.

---

## Phase 2 — Data Structures (Weeks 5–8)

Build the classic structures yourself, always with explicit allocator parameters where it makes sense.
Scaffolded in `phase_02_ds/` (see its `README.md` for order + standing rules):

| # | Folder | Focus | Key deliverable |
|---|--------|-------|-----------------|
| 01 | `01_stretchy_buffer` | parametric growable array, 1.5x vs 2x | growth benchmark |
| 02 | `02_linked_lists` | singly + doubly + pool-backed | churn comparison |
| 03 | `03_stack_and_queue` | slice vs linked, reuses 01–02 | bracket-matcher + task drain |
| 04 | `04_hash_set` | open addressing, tombstones | dedup app + probe stats |
| 05 | `05_hashmap` | owned keys, resize proof | config-table demo |
| 06 | `06_ring_buffer` | fixed cap, strict vs overwrite | event/log/window app |
| 07 | `07_heap_priority_queue` | binary heap on 01, comparator | timer/frontier/top-N |
| 08 | `08_ds_torture_and_bench` | capstone harness | torture green + BENCH.md + winners table |

Each must document which allocator it uses and how ownership works.

---

## Phase 3 — Algorithms + Short Paper Adventures + Format Parsers (Weeks 9–14)

- Sorting (a few classics + comparison)
- Searching, binary search on sorted data
- Basic string algorithms
- **Adventure challenges** (1–3 day each): read a short paper or classic algorithm write-up and implement a minimal version. Examples:
  - Simple noise (OpenSimplex ideas)
  - Basic pathfinding (A* lite)
  - A tiny parser combinator or recursive descent
  - A classic numerical method or geometric algorithm
- **Document & media format adventures** (also short, practical):
  - Minimal XML / HTML subset parser
  - Simple PDF object / cross-reference table reader (read-only subset)
  - Basic WAV or raw audio frame understanding
  - Tiny container demux ideas (e.g. simplified RIFF or ISO BMFF concepts)
  - JSON is already familiar; push into a stricter or streaming variant

These are meant to be short, fun, and documented with “what I learned from the paper / spec”.

---

## Phase 4 — Core Library Mastery & Rebuilds (Months 3–4)

Study and selectively re-implement simplified versions of useful `core:` pieces so you understand them deeply:

- fmt-style formatting helpers
- string utilities
- path / filepath helpers
- a tiny subset of os / file handling
- logging
- a simple event or signal system

Rule: when you rebuild, document what the real `core:` version does better.

---

## Phase 5 — First Real Tools (Months 4–5)

Small but complete command-line tools that reuse your earlier packages:

- config + logger based CLI utility
- simple file processor / log parser
- tiny static site or markdown processor
- a “project helper” that will later integrate with the editor
- one tool that uses a format parser from Phase 3 (e.g. XML stats or simple PDF info)

---

## Phase 6 — Systems & Win32 (Months 5–6)

- Deeper `core:sys/windows` usage
- Window creation, message loop, basic input
- File mapping / virtual memory experiments via `core:mem/virtual`
- Simple custom allocators backed by virtual memory
- Optional: basic networking or process control

This phase prepares the ground for the GUI library.

---

## Phase 7 — GUI Library (Months 6–8)  ★ major milestone

Build a small but usable GUI toolkit.

Suggested progression:
1. Window + message / event loop (Win32 via `core:sys/windows` or cross-platform abstraction)
2. Basic drawing (rectangles, text)
3. Input handling (mouse, keyboard, focus)
4. Widget set: button, label, text field, list, scroll region
5. Simple layout (row/column or immediate constraints)
6. Theming / style separation

**Shippable definition:** a library + several demo applications that feel responsive. Own repository recommended.

Study (do not copy wholesale):
- Odin community GUI experiments
- Dear ImGui design notes / immediate-mode literature
- Win32 UI patterns
- Any small retained-mode toolkit whose source you can read

---

## Phase 8 — Text Editor (Months 8–11)  ★ major milestone

A real (if modest) text editor built on *your* GUI library and earlier tools.

Must-have:
- Multi-buffer / multi-file
- Gap buffer, piece table, or rope (research + choose)
- Basic editing + undo/redo
- Syntax highlighting for at least Odin (or a simple language) using your tokenizer or a new one
- File open/save
- Integration points for your earlier tools (logger, config, project helper)

Nice-to-have:
- Search / replace
- Simple git status display (if you later build version-control helpers)
- Split views

**Shippable definition:** you can comfortably edit Odin source with it and use it for the next phases.

---

## Phase 9 — Internal Tools + Dogfooding (Months 11–14)

- Build or improve tools *using* the editor
- Project browser / launcher
- Simple build / run integration
- Notes or TODO system living inside the editor ecosystem
- Continuous improvement of the GUI and editor based on daily friction

The loop is intentional: editor improves the tools → tools improve the editor.

---

## Phase 10+ — Productization & Capstones (Months 14–18)

- Extract the strongest packages into clean, documented repositories
- Proper READMEs, examples, and basic tests where useful
- More paper re-implementations at higher fidelity
- Deeper format tools (more complete PDF subset, structured document tools, etc.)
- One or two larger capstone projects of your choosing (game prototype, specialized tool, systems experiment, etc.)
- Living best-practices document collected throughout the journey

---

## Cross-cutting quests (whole journey)

- **Q-MEMORY:** Every non-trivial allocation should be intentional and documented (which allocator, who owns it, when it dies).
- **Q-READ:** Regularly read real Odin `core:` source or a paper and write short notes.
- **Q-REUSE:** Later packages and apps must import or clearly cite earlier ones.
- **Q-SHIP:** At major milestones (GUI, editor, tools) produce something you can put on GitHub with a clear README.
- **Q-DOGFOOD:** Once the editor exists, prefer it for further work on this project.
- **Q-FORMAT:** At least a few times implement a minimal reader for a real document or media format from its specification or a clear secondary source.

---

## Completion mindset

A phase is done when the artifacts run, demonstrate the intended capability, and can be reused by later work.  
Perfection is not required. Deep understanding and shipping are.
