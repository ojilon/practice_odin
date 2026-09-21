# Phase 2 — Data Structures (Weeks 5–8)

Build the classics yourself, with explicit allocators, so every later phase can *use* them instead of re-learning them.

## Map
| # | Folder | Structure | Later consumer |
|---|--------|-----------|----------------|
| 01 | `01_stretchy_buffer` | growable array beyond the builtin | parsers, log tools (Ph 3/5) |
| 02 | `02_linked_lists` | singly + doubly linked, pool-backed option | editor buffers, entity lists (Ph 8) |
| 03 | `03_stack_and_queue` | slice-backed + linked variants | undo, tokenizer, job queues (Ph 5/8) |
| 04 | `04_hash_set` | open-addressed set | interning, dedup, symbol sets (Ph 3/5) |
| 05 | `05_hashmap` | hashmap with tombstones + resize | configs, symbol tables (Ph 5/8) |
| 06 | `06_ring_buffer` | fixed-capacity ring, overwrite vs error | frame history, audio, input events (Ph 6/7) |
| 07 | `07_heap_priority_queue` | binary heap / priority queue | scheduler, A*, event ordering (Ph 3/7) |
| 08 | `08_ds_torture_and_bench` | capstone: torture + benchmark all | picks winners for Ph 3+ |

## Standing rules (all folders)
1. **Allocator explicit.** Each owning type stores its allocator (param at make, or documented `context.allocator` capture) and provides a `destroy`/`free` proc. No ownerless memory.
2. **Invalidation documented.** Grow/clear/remove/destroy sections state what happens to outstanding slices, pointers, and stored indices.
3. **Tracking silent.** Every happy path *and* every error path runs clean under `common/dojo_debug` tracking. Error paths that leak are failures.
4. **Compare with builtin.** Each folder ends with one paragraph: what does the builtin / `core:container` equivalent do better, and when would you still pick yours?
5. **Reuse forward.** The capstone (08) imports 01–07. Phase 3+ imports the winners. Write code you would actually import.

Read `core_notes/07_allocators_deep.md` again before starting, and skim `Open Data Structures` (see `RESOURCES.md`) for the theory behind each structure.

Suggested order: 01 → 03 → 06 → 02 → 07 → 04 → 05 → 08. (Simpler ownership first, hashing last.)
Suggested pace: ~4–5 days per folder, capstone ~1 week.
