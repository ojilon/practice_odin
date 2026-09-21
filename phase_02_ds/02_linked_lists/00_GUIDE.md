# 02 — Linked Lists (Singly + Doubly, Then Pool-Backed)

> Package suggestion: `ds_list`  
> Read first: `core_notes/07_allocators_deep.md` (pool row)

## Why this exists
Lists teach per-node ownership — the opposite of arena batching. You will feel exactly when per-node `new`/`free` is right (sparse insert/remove, stable handles) and when it is wasteful churn (sequential scans the buffer does better). The pool-backed variant previews entity and editor-node management.

## Steps (simple → complex)
1. Singly linked: `SNode($T)` + `SList($T)` with head/tail/len + stored allocator; `push_front/push_back/pop_front`, `find`, `remove_value`. Free every removed node exactly once.
2. Doubly linked: `DNode($T)` with prev/next + `DList($T)`; `push_back/pop_back/insert_after/remove_node(^Node)`. Prove O(1) removal given the node handle.
3. Handle discipline: document what a `^Node` means after removal (dangling — never reuse). Deliberate use-after-remove trap once (labeled), then the rule.
4. Pool backing: allocate `DNode`s from a freelist/pool (reuse freed nodes) instead of heap per node; show churn workload (insert/remove ×10k) with allocation counts heap-vs-pool.
5. Comparison: same workload (sequential fill + scan + sparse removes) on your list vs your Phase-2-01 buffer. Time + allocation counts. Write the verdict: which shape for which access pattern?

## Constraints
- Every node allocated with the list's stored allocator; every removal path frees (or recycles to pool) — including the error/not-found paths.
- Doubly-linked pointer surgery must hold under: empty, single-node, head-remove, tail-remove, mid-remove. Test all five explicitly.
- No global node pool. The pool belongs to the list instance.

## Done when
- Both list flavors pass the five-case removal matrix with tracking silent.
- Pool variant demonstrates node reuse with printed alloc counts.
- Verdict paragraph (list vs buffer) with numbers, plus builtin-comparison paragraph.
