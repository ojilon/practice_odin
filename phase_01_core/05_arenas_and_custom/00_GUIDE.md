# 05 — Arenas & Custom Allocators

> Prerequisite: `core_notes/07_allocators_deep.md` (plus `04_memory.md` re-read)  
> Package suggestion: `arenas_custom`

## Why this exists
Real Odin programs are designed around lifetimes, not individual frees. Arenas give you batch lifetimes; a custom allocator teaches you the `mem.Allocator` interface from the inside. Both pay off in every phase after this — parsers, tools, GUI frames, editor buffers.

## Steps (simple → complex)
1. Arena batch: create an arena, allocate a dynamic array + several strings/slices from it, use them, then `free_all` once. No per-item deletes. Prove tracking-quiet via the arena's backing tracker.
2. Arena reset + reuse: `free_all`, then run the same workload again in the same arena. Show peak memory stays flat across iterations.
3. Scope discipline: demonstrate what must NOT escape an arena clear (a stored slice used after `free_all` → deliberate broken version, then fixed by cloning out or extending the arena's life).
4. Custom allocator: implement the `mem.Allocator` interface as a thin wrapper (count allocations/frees/bytes, then forward to backing). Use it for one demo workload and print the stats.
5. Swap test: run the same workload on heap vs arena vs your wrapper. Note which code changed (ideally: one allocator assignment) and which code *had* to change (per-item frees vs batch clear).

## Constraints
- The arena demo must not contain per-item `delete` of arena memory — that defeats the point and usually double-frees.
- Your custom allocator must handle zero-size and alignment correctly by forwarding faithfully; no clever packing yet.
- Broken escape-after-clear version stays labeled and out of the happy path.

## Done when
- One arena demo with batch free + reuse-flat-peak, one custom-allocator demo with stats, and a 3-line comparison (heap vs arena vs wrapper).
- You can draw the lifetime diagram for each demo: what allocates, what frees, what invalidates.
- Tracking (over the backing allocator) is silent on every happy path.
