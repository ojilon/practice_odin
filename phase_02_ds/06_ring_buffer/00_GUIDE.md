# 06 — Ring Buffer (Fixed Capacity, Two Policies)

> Package suggestion: `ds_ring`

## Why this exists
Input events, undo trails, frame histories, audio sample windows, log tails — all bounded, all overwrite-or-reject by design. Rings teach index-wrap arithmetic and the overwrite-vs-error decision that unbounded structures never force you to make.

## Steps (simple → complex)
1. Layout: `Ring($T)` with fixed `cap`, backing slice, `head/tail/count` (or head+count) + stored allocator; `ring_make(cap, allocator)`, `ring_destroy`, `ring_len/cap/is_empty/is_full`.
2. Push/pop core: `ring_push -> bool` + `ring_pop -> (T, bool)` with wrap arithmetic (`idx = (head + n) % cap`); prove wrap with a small cap (e.g. 4) and printed slot states.
3. Policy split: `ring_push_overwrite` (oldest drops, returns evicted `(T, true)`) vs strict `ring_push` (`false` when full). Demo both on the same overflow input; state which later system wants which.
4. Peek + drain: `ring_peek(i) -> (T, bool)` (i-th oldest without removing), `ring_drain` (pop-all in order), `ring_clear`. Off-by-one matrix: empty pop, full push, wrap-boundary peek, clear-reuse.
5. Applied pass: pick one — input-event queue (push 10 events into cap-4 ring, show overwrite keeps newest), log-tail (last-N lines of a hardcoded log), or sample window (running sum over last-N ints). Tracking silent, overwrite losses counted and printed.

## Constraints
- Capacity fixed at make; never silently regrows. Growth is a different structure (go use 01).
- Modulo arithmetic centralized in one helper proc — no scattered `% cap` with different edge behavior.
- Overwrite losses are counted, not silent: the demo prints evicted values or a drop counter.

## Done when
- Wrap + both policies proven on a tiny cap with printed states; off-by-one matrix all green.
- Applied demo (events / log-tail / window) runs with drop counts.
- One paragraph: ring vs queue (03) vs unbounded buffer (01) — which bounded problem takes which?
