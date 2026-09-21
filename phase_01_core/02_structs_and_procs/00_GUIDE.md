# 02 — Structs & Procs

> Prerequisite: `core_notes/02_structs_procs.md`  
> Package suggestion: `structs_procs`

## Why this exists
Everything later — data structures, GUI widgets, editor buffers — is a struct plus procedures with clear ownership. This folder builds the habit: small data, pointer-vs-value discipline, handles that can't be mixed up.

## Steps (simple → complex)
1. Define a small struct (2–4 fields) and procedures that construct, update (via `^T`), and describe it.
2. Add a `distinct` handle type (e.g. an ID) and use it in at least one procedure signature so mixing raw ints fails to compile.
3. Write one overloaded procedure (same name, two signatures) and one parametric procedure (`$T`) with at least two concrete uses.
4. Sketch one Array-of-structs vs Struct-of-arrays pair for the same data; write the iteration loop for each and note which field access each loop touches.

## Constraints
- No hidden allocation: if anything allocates, say which allocator.
- Default to private symbols; export only the demo surface. (You will formalize this in folder 08 — start the habit now.)
- One generic with a single use is a failure — either find the second use or keep it concrete.

## Done when
- A demo constructs values, mutates through pointers, uses the distinct handle, and calls both the overloaded and parametric procs.
- You can state for each proc why its parameters are by value or by pointer.
- `odin run .` succeeds and the output shows each capability exercised.
