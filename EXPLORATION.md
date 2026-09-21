# Exploration — Learning From Real Systems & Papers

A significant part of growth comes from reading real code and short papers, then turning the ideas into small experiments.

Do one exploration activity regularly. Keep short notes.

---

## 1. Reading Odin `core:` source

The `core:` library is unusually approachable. Recommended early targets:

- `core:mem` (especially allocators, tracking allocator, arenas)
- `core:fmt`
- `core:strings` and string builders
- `core:os` and path helpers
- `core:sys/windows` (when you reach GUI / systems work)
- `core:container` packages

Method:
1. Read the package documentation / overview comments.
2. Trace one or two key procedures.
3. Note the allocator and lifetime choices.
4. Ask what you would keep or simplify for your own version.

---

## 2. Short paper / algorithm adventures

These are deliberately small (1–3 days). Examples of good targets:

- Classic sorting / searching write-ups
- OpenSimplex or simple noise papers / descriptions
- Basic A* or Dijkstra explanations
- Gap buffer / piece table / rope papers or articles (critical for the editor)
- Immediate-mode GUI papers and talks (critical for the GUI phase)
- Simple numerical or geometric algorithms

For each adventure:
- Read the source material
- Implement a minimal version in Odin
- Write 5–10 lines on what you learned and what you simplified

---

## 3. Other codebases worth studying later

- Small Odin projects in the wild (games, tools, GUI experiments)
- Dear ImGui design and immediate-mode literature
- Win32 sample code and classic UI programming texts
- Educational text-editor implementations (any language) for buffer strategies

---

## 4. Collecting best practices

Maintain a living `BEST_PRACTICES.md` (or notes in `PROGRESS.md`) with short entries:

- Pattern observed
- Where you saw it
- Why it is useful (or why you rejected it)
- Where you applied it in your own code

This becomes especially valuable when productizing and when dogfooding the editor.

---

## 5. Rules

- Prefer understanding + re-implementation over large copy-paste.
- Always attribute significant design ideas.
- Exploration is required fuel for the GUI, editor, and paper phases.
