# 03 — Stack & Queue (Two Backings Each)

> Package suggestion: `ds_stack_queue`

## Why this exists
Undo history, tokenizer nesting, parser recursion, GUI event queues, job queues — all of these are a stack or a queue wearing a costume. Building both backings (slice-backed for cache + speed, linked for stable handles / no regrow) teaches you to pick by access pattern instead of habit.

## Steps (simple → complex)
1. Slice-backed stack: `Stack($T)` over your `01` Buffer (reuse it — don't rewrite growth); `push/pop/peek`, `clear`, underflow returns `(T, bool)`.
2. Linked stack: same interface over your `02` singly list (or minimal nodes); compare code size + alloc counts vs slice version on 10k push/pop.
3. Slice-backed queue with head index: `Queue($T)` with `enqueue/dequeue/peek/len`; handle head-drift (compact or ring — document the choice and its cost).
4. Linked queue: front/back pointers, O(1) both ends; same 10k workload comparison.
5. Real-use demo: pick one — bracket-matcher over a hardcoded string (stack) + FIFO task drain printing order (queue); or undo-stack sketch (push states, pop to restore). Underflow/empty paths print clean messages, tracking silent.

## Constraints
- Reuse `01` and `02` — import them or write one paragraph per structure explaining why the builtin was deliberately chosen instead. No silent rewrites of logic you already own.
- Empty `pop`/`dequeue`/`peek` never panic in the demo; they return `(T, bool)` and the demo handles `false`.
- Queue must not leak memory via unbounded head-drift: either compact, ring-wrap (preview of 06), or document the bound with a failing test past it.

## Done when
- All four variants (stack×2, queue×2) run the same workload with printed time + alloc counts and a pick-one verdict per use (LIFO vs FIFO, slice vs linked).
- Real-use demo (brackets or undo + task drain) works on at least three inputs including empty and malformed.
- Tracking silent on happy + underflow paths.
