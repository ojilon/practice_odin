# Exercises — Arenas & Custom Allocators

## Must implement / demonstrate
1. Arena batch workload: an arena backing at least one `[dynamic]` collection plus 3+ derived strings/slices; single `free_all` teardown; no per-item deletes of arena memory.
2. Arena reuse proof: loop the workload 3× with `free_all` between iterations; print arena peak/used (or allocation counts) showing flat reuse.
3. Escape-after-clear trap: broken version (use arena memory after `free_all`) + fixed version (clone to heap/caller buffer, or extend arena lifetime). Label clearly.
4. Custom counting allocator: a struct implementing the `mem.Allocator` proc interface that forwards to a backing allocator while counting calls + bytes; demo prints `allocs / frees / bytes_allocated` for a fixed workload.
5. Allocator-swap comparison: same logical workload run on (a) heap, (b) arena, (c) your wrapper — one short paragraph on what changed and what the trade-off is.

## Stretch
- Fixed-buffer scratch allocator: allocate from a `[4096]u8` (or similar) stack buffer with graceful fallback-or-fail on overflow; prove the overflow path is handled, not silent.
- Pool preview: freelist for one fixed-size node type with reuse (allocate → free → allocate returns recycled slot). One paragraph on when pools beat arenas.
- Two-arena frame sketch: persistent arena + scratch arena cleared per "frame" of a loop; document what lives where and why (direct preview of the GUI/frame split).

## Banned / discouraged
- Per-item `delete` of arena-owned memory in the happy path.
- Custom allocators that ignore alignment, zero-size, or old-size arguments.
- An arena that never clears across an unbounded loop ("arena leak").
