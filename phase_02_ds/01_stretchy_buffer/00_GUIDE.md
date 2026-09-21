# 01 — Stretchy Buffer (Growable Array Beyond the Builtin)

> Package suggestion: `ds_buffer`  
> Read first: `phase_02_ds/README.md`, `core_notes/03_slices.md` + `07_allocators_deep.md`

## Why this exists
You already use `[dynamic]T`. Now you learn what it *does*: growth policy, capacity discipline, invalidation, and the `clear`-vs-`delete` split. Every parser, log tool, and tokenizer downstream needs a buffer whose behavior you can predict — this is that buffer, parametric over `$T`.

## Steps (simple → complex)
1. Type + lifecycle: `Buffer($T)` struct holding `data: [dynamic]T` (or raw ptr+len+cap you manage) plus stored allocator; `buf_make`, `buf_destroy`, `buf_clear`, `buf_len`, `buf_cap`.
2. Push + growth: `buf_push` with a documented policy (start at 2x, then compare 1.5x in the benchmark). Print len/cap across a 0→200 push run and mark each regrow.
3. Borrowed views: `buf_slice` returning `[]T` with a comment on invalidation (any push-may-grow invalidates). Demonstrate stale-view breakage once (labeled), then the fix (re-acquire after push).
4. Bulk + remove: `buf_push_slice` (append N at once with single growth), `buf_pop` + `buf_remove` (swap-remove documented as order-breaking, or shift-remove documented as O(n)).
5. Policy comparison: run the same 100k-push workload under 1.5x vs 2x vs pre-sized; record time + peak + waste in your questions file (first real Phase 2 benchmark).

## Constraints
- Parametric over `$T`; instantiate with at least two types (e.g. `u8` bytes and a small struct) in the demo.
- Allocator stored at make; `destroy` uses the stored allocator, not whatever `context.allocator` happens to be at destroy time.
- No `defer` inside the push loop; no silent truncation on remove/pop-empty (return `(T, bool)` or an error).

## Done when
- Demo pushes 200+ items across regrows, pops/removes, clears + reuses, destroys — tracking silent throughout.
- `BENCH.md` or questions-file entry: 1.5x vs 2x vs pre-sized numbers with machine + flags.
- One paragraph: when do you use this vs the builtin `[dynamic]T` vs a fixed buffer?
