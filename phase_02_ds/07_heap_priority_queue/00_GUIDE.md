# 07 — Binary Heap & Priority Queue (Scheduler Preview)

> Package suggestion: `ds_heap`

## Why this exists
Schedulers, timers, A*/Dijkstra frontiers, event ordering, "top-N" extraction — all need repeated min/max, not full sorting. A binary heap gives O(log n) push/pop with a tiny array, and the sift math teaches index reasoning that transfers to every tree later.

## Steps (simple → complex)
1. Layout: `Heap($T)` over your 01 Buffer (reuse — heaps are arrays with discipline) + comparator hook (`less(a, b) -> bool`); `heap_make(less, allocator)`, `heap_destroy`, `heap_len`, `heap_peek -> (T, bool)`.
2. Sift pair: `heap_push` (sift-up) + `heap_pop -> (T, bool)` (swap-remove + sift-down). Parent/child index math in one commented helper; empty pop returns false.
3. Correctness proof: push 20 shuffled ints, pop-all prints sorted order (min-heap) — then flip comparator and show max-heap order. Include duplicates + already-sorted + reverse-sorted inputs.
4. Priority tasks: `Task { priority, name, seq }` with tie-break rule you state (priority, then seq for FIFO-among-equals); enqueue 8 tasks, drain in order, print tie handling.
5. Applied preview: one — timer/event line (pop tasks in priority order, skip cancelled flag), A*-frontier sketch (push nodes with f-score, pop lowest, no full pathfinder required), or top-N (stream 1000 ints, keep largest 5 via min-heap of 5).

## Constraints
- Backed by folder 01 (import it) — heaps don't need their own growth code. Document the comparator contract (strict weak ordering; equal priorities need the tie-break).
- Index math centralized + commented: `parent(i) = (i-1)/2`, `left = 2i+1`, `right = 2i+2`. Off-by-one here corrupts silently — the pop-all-sorted proof is the detector.
- No linear-scan "find-min" fallback in the happy path; `peek` is O(1), `pop` is O(log n) — state both in a comment.

## Done when
- Pop-all-sorted proven for min + max + duplicates + edge orders; task drain respects priority + tie-break.
- Applied preview runs (timers, frontier sketch, or top-N).
- Complexity + comparator notes written; tracking silent including empty-pop paths.
