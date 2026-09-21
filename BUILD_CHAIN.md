# Build Chain — Use What You Built

Principle: **language core + memory discipline → your data structures & utilities → tools → systems/Win32 → GUI library → editor → dogfooding tools that improve the whole stack**.

---

## Layer 0 — Language + Memory

Everything rests on solid understanding of:
- procedures, structs, distinct types, parametric polymorphism
- slices, dynamic arrays, maps
- `context.allocator`, temp allocator, arenas, tracking allocator
- ownership and lifetime thinking

These are the Phase 1 packages.

---

## Layer 1 — Your data structures & small utilities

You build (with explicit allocators):
- lists, stacks, queues, sets, hash maps, ring buffers, heaps
- string helpers / builders beyond the basics
- simple logging and config helpers

Later packages prefer these (or document why they chose the built-in).

---

## Layer 2 — Core-inspired rebuilds & first tools

Selective simplified re-implementations of useful `core:` ideas, plus small CLI tools that compose your packages.

---

## Layer 3 — Systems & Win32 foundation

Windowing, input, virtual memory, custom allocators backed by the OS.  
This layer exists primarily to support a real GUI library.

---

## Layer 4 — GUI library

Your own toolkit. It depends on:
- your event / input handling ideas
- your data structures for widget trees or immediate data
- your logger and config
- the systems/Win32 work

---

## Layer 5 — Text editor

Built on the GUI library. It further depends on:
- text buffer data structure (researched + implemented)
- your tokenizer / highlighter
- config, logger, any project helpers
- file and path utilities

---

## Layer 6 — Dogfooding & internal tools

Tools that live inside or beside the editor and are used to improve the editor, the GUI, and the earlier packages. The feedback loop is intentional.

---

## Layer 7 — Productization

Extract the strongest pieces into clean repositories, document them, and continue improving them by actual use.

---

## Standing rules

1. Allocations are never invisible. Know the allocator and the lifetime.
2. Prefer your own earlier packages when they fit; document deliberate deviations.
3. Study `core:` source freely; re-implement ideas rather than wrapping without understanding.
4. At every major layer, produce something runnable with a short README.
