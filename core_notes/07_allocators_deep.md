# Allocator Zoo & Lifetime Design (deep cut)

> Read before: `phase_01_core/05_arenas_and_custom`, then re-read before Phase 2 and Phase 6.

This note is the bridge from "allocators exist" to "I design lifetimes on purpose".

## The zoo (what each one is for)
| Allocator | Best for | Frees how | Watch out |
|-----------|----------|-----------|-----------|
| `context.allocator` (default heap) | general, long-lived | per-item `free`/`delete` | leaks if ownership is vague |
| Temp allocator | per-frame / per-request scratch | one `free_all` | dangling use-after-clear |
| Arena (`mem.Arena`) | batch work with one death point (parse, build, level load) | `free_all` or destroy | unbounded growth if never cleared; not for items with different lifetimes |
| Stack / fixed buffer (`mem.Scratch` style) | tiny hot scratch, no heap at all | reset | overflow on large inputs — always check |
| Pool / freelist | same-size churn (entities, nodes, particles) | per-item free back to pool | fragmentation of *meaning* if you forget to reinitialize on reuse |
| Tracking (wrapper) | debug builds over any of the above | reports leaks/bad frees | small overhead — debug only |
| Custom (your `05` exercise) | virtual-memory backing, tagged stats, game-frame budgets | your rules | must still implement the full `mem.Allocator` interface correctly |

## Lifetime design questions (ask for every structure)
1. Who allocates, and with which allocator?
2. Who frees, and when — per item, batch clear, or scope exit?
3. Can it grow? What happens to outstanding slices/pointers on regrow?
4. Can it be moved/copied? What does a copy mean for ownership (deep vs borrow)?
5. What does the tracking allocator report on the happy path? (Answer: silence.)

## Patterns that survive contact with real code
- **Arena-per-task:** parse a file, build IR, emit output, `free_all`. No per-node frees. Phase 3 parsers and Phase 5 tools live on this.
- **Two-arena frame:** one persistent arena (survives frames), one scratch arena (cleared per frame). GUI (Phase 7) and editor (Phase 8) need exactly this split.
- **Pool for nodes:** linked-list / entity nodes come from a pool so churn doesn't touch the heap. Phase 2 linked lists preview this; Phase 6 makes it OS-backed.
- **Caller-provides-buffer:** hot procedures take `buf: []T` instead of allocating. Zero allocation, zero ambiguity. Use wherever profiling justifies it.

## Anti-patterns (you will meet all of these — catch them early)
- Arena that never clears ("just put it in the arena" × 1000 = slow leak).
- Temp string smuggled into a long-lived map key.
- Dynamic array grown inside a loop with per-iteration `defer delete` in the same scope (defers pile up).
- Custom allocator that ignores alignment or zero-size requests — works until it corrupts.

## What to practice
- Draw the lifetime diagram for every Phase 2 structure: allocation points, free points, invalidation events (grow/clear/destroy).
- Run every demo under the tracking allocator *and* once with the backing allocator swapped (heap → arena) to feel which structures tolerate batch lifetimes and which genuinely need per-item free.

## Resources
- `core:mem` source: `arena`, `tracking_allocator`, `heap`, `virtual` overview.
- Ginger Bill's allocator essays (arena / temp / scratch framing).
- Ryan Fleury / Allen Webster writings on arena-centric program structure (for the arena-per-task mindset, not for copying).
