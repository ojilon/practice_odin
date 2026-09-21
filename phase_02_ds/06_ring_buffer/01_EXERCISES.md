# Exercises — Ring Buffer

## Must implement (`ds_ring`, parametric `$T`, ≥2 instantiations)
1. `Ring($T)`: `ring_make(cap, allocator)` (reject cap 0 with bool/error), `ring_destroy`, `ring_len/cap/is_empty/is_full`.
2. `ring_push(r, v) -> bool` (strict: false when full), `ring_push_overwrite(r, v) -> (evicted: T, did_evict: bool)`, `ring_pop(r) -> (T, bool)`, `ring_peek(r, i) -> (T, bool)` oldest-indexed, `ring_clear`, `ring_drain` (ordered pop-all into caller buffer or prints).
3. Wrap proof: cap-4 demo printing `(head, count, slots)` after every op across a 10-push / 6-pop sequence that wraps ≥2 times.
4. Overwrite demo: same overflow input through strict (rejections counted) vs overwrite (evictions listed); print both tallies.
5. Off-by-one matrix: pop-empty, peek-past-end, push-to-exactly-full, fill-drain-refill, clear-then-wrap — expected vs observed each.
6. Applied build (pick one, ship it):
   - event queue: 10 input events into cap-4 overwrite ring, drain newest-4 in order + drop count; or
   - log tail: 20 hardcoded lines into cap-5, print last 5 in order; or
   - sliding window: running sum/average over last-N of 20 ints, printed per step.

## Stretch
- Power-of-two mask variant (`idx & (cap-1)`) beside modulo version; measure 1M ops each, record whether it matters on your machine.
- Blocking-shape sketch: single-producer/single-consumer comments (who owns head vs tail) without real threads — what would need atomics later?
- Zero-alloc peek-batch: `ring_peek_two_slices` returning the (contiguous-A, wrapped-B) pair so callers scan without copying; document the two-slice contract.

## Banned / discouraged
- Silent regrow or silent drop (every policy outcome is returned + counted).
- Scattered wrap arithmetic with inconsistent edges — one helper, one rule.
- `pop`/`peek` panicking on empty in demo code.
