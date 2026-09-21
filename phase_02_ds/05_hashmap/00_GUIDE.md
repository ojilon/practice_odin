# 05 — Hashmap (Keys With Owned Memory)

> Package suggestion: `ds_hashmap` (may import `04` concepts — implement fresh, cite reuse)  
> Read first: your own 04 tombstone notes + `core_notes/05_maps_strings.md` key-ownership section

## Why this exists
Configs, symbol tables, file indexes, entity properties — maps are the working memory of tools and editors. The builtin is fine; this folder exists so key ownership, resize, and probe behavior are *yours* to reason about when the editor's symbol table misbehaves at 2am.

## Steps (simple → complex)
1. Layout: `Map($K, $V)` open-addressed like 04 (or chained — pick one, justify in one paragraph); `map_make`, `map_destroy`, `map_put`, `map_get -> (V, bool)`, `map_remove -> bool`, `len/cap/load`.
2. Key ownership contract: string keys cloned into the map's allocator on put, freed on remove/destroy/resize-old-table. Borrowed-key trap demo (labeled broken using temp keys → fixed with clones), mirroring Phase-1-06.
3. Value semantics: document whether `map_get` returns a copy or a pointer into the slot — and what a later `put` (resize!) does to outstanding pointers. Stale-pointer trap once (labeled), then the rule.
4. Resize + rehash: threshold + full rehash preserving ownership (keys move, not re-cloned); print regrow events; verify all entries survive 2+ resizes with a checksum (sum of values or key count).
5. Real-use demo: tiny config/symbol table — hardcoded `key=value` lines parsed (reuse your tokenizer instincts) into the map, 3+ lookups (hit + miss), one remove, sorted dump via collected keys + sort (reuse 01 buffer for key list).

## Constraints
- No temp-borrowed keys stored past their lifetime in the happy path; ownership contract in a comment at the type.
- Resize must not leak old tables or double-free moved keys — tracking proves it across 2+ resizes.
- Iteration order unspecified: any ordered output sorts explicitly.

## Done when
- Full CRUD correct across resizes with checksum proof; key-ownership trap pair + stale-pointer rule documented.
- Config demo runs end to end with sorted dump.
- Verdict paragraph: yours vs builtin `map[K]V` — when do you pick which?
