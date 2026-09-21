# Exercises — Linked Lists

## Must implement (`ds_list`, parametric `$T`, ≥2 instantiations in demo)
1. `SList($T)`: `slist_make(allocator)`, `slist_destroy`, `slist_push_front/back`, `slist_pop_front -> (T, bool)`, `slist_find(val) -> ^SNode(T)`, `slist_remove_value(val) -> bool`, `slist_len`. All removals free the node.
2. `DList($T)`: `dlist_make/destroy`, `dlist_push_back`, `dlist_pop_back -> (T, bool)`, `dlist_insert_after(list, node, val)`, `dlist_remove_node(list, node)` O(1). Demo exercises empty / single / head / tail / mid removals with len checks after each.
3. Handle-safety trap: labeled broken version reusing a `^Node` after removal + documented rule (handles die with removal; re-find, don't cache across mutations).
4. Pool-backed `DList`: freelist of recycled nodes inside the list; `pool_stats` (allocs from backing vs reuses); 10k insert/remove churn demo printing both counters for heap-mode vs pool-mode.
5. List-vs-buffer shootout: fill 10k + full scan + remove every 7th element, timed on `DList` vs your `01` Buffer. Record time + allocation counts + one-paragraph verdict.

## Stretch
- Intrusive-node sketch: node struct the *caller* embeds (no per-node alloc at all) — 1-page note on when intrusive beats allocated nodes (entity lists, editor line lists).
- Reverse + splice: `dlist_reverse` in place, `dlist_splice(dst, src)` moving nodes without realloc; prove with order prints.
- Arena-backed list: whole list in an arena with batch teardown and *no* per-node frees — document what breaks (mid-life removal can't reclaim) and when that trade is fine.

## Banned / discouraged
- Forgetting to free on the not-found / empty error paths (still tracking-clean there).
- Caching `^Node` across arbitrary mutations and dereferencing without revalidation.
- A shared/global pool; pools are per-list-instance state.
