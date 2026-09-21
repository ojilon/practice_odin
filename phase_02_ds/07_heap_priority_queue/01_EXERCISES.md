# Exercises — Binary Heap & Priority Queue

## Must implement (`ds_heap`, parametric, backed by `01` Buffer)
1. `Heap($T)`: `heap_make(less: proc(a, b: T) -> bool, allocator)`, `heap_destroy`, `heap_push(h, v)`, `heap_pop(h) -> (T, bool)`, `heap_peek(h) -> (T, bool)`, `heap_len`. Comparator stored, documented as strict ordering + tie rule.
2. Index helpers (one place, commented): parent/left/right + sift-up/sift-down; state O(log n) push/pop + O(1) peek in a comment.
3. Sort-proof: 20 shuffled ints → pop-all prints ascending (min-heap); flip to max comparator → descending; plus duplicates-only, sorted-in, reverse-sorted-in runs. All printed.
4. Priority tasks: `Task { priority: int, seq: int, name: string (owned per contract) }`; 8 tasks incl. 3 tied priorities; drain prints exact order proving tie-break (suggest FIFO-by-seq).
5. Applied build (pick one):
   - timers: tasks with `fire_at` tick, pop in order, one cancelled-flag task skipped with message; or
   - frontier sketch: `(f_score, node_id)` pushes/pops simulating A* frontier order (no full search needed); or
   - top-N: stream 1000 pseudo-random ints, maintain min-heap of 5 largest, print the 5 sorted.
6. Edge matrix: pop/peek-empty, single-element, all-equal priorities, push-after-drain-reuse — each with expected vs observed.

## Stretch
- `heap_update / heap_remove_at`: sift-both-ways repair after mutating index i (needed for real schedulers with reprioritization); prove with a reprioritize-then-drain demo.
- Benchmark: heap push+pop ×100k vs full sort of 100k (`slice.sort` or your Phase-3 sort later) for repeated-min extraction — when does the heap win?
- D-ary sketch: 4-ary heap notes or prototype; one paragraph on shallower trees vs more compares per level.

## Banned / discouraged
- Rewriting array growth inside the heap (import 01).
- Comparators with nondeterministic ties (equal priorities must still drain deterministically via seq or stated rule).
- Panicking on empty pop/peek in demo code.
