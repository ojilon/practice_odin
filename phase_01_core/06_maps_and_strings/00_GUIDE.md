# 06 — Maps & Strings

> Prerequisite: `core_notes/05_maps_strings.md`  
> Package suggestion: `maps_strings`

## Why this exists
Config files, symbol tables, token maps, file indexes — everything downstream keys strings to values and builds output. The ownership trap (map keys borrowing dead memory) is the single most common Phase 5/8 bug. Learn it here on purpose.

## Steps (simple → complex)
1. Basic map: `make` with explicit allocator, insert/lookup/delete with the `(value, ok)` form, `delete` at the end. Print hits and misses separately.
2. Key-lifetime trap: insert a temp-built string key, clear the temp storage, look it up (broken) — then fix by cloning keys into the map's allocator. Keep both versions labeled.
3. Iteration + determinism: iterate a map, collect keys, sort them, print sorted. Prove output is stable across runs.
4. Builder output: accumulate a report with `strings.builder` (pre-sized), including numbers and joined fields; destroy/reset at a clear point. Return one string with a documented contract: caller-deletes clone vs borrowed view.
5. Mini word-count: tokenize a hardcoded paragraph into a `map[string]int`, print sorted frequencies. This is the direct ancestor of the Phase 5 log parser.

## Constraints
- Map key ownership must be explicit: literal (static, safe), cloned (owned by map), or borrowed with a documented shorter-or-equal lifetime. No mystery keys.
- No dependency on iteration order. If output order matters, sort.
- String-returning procs state the contract in a comment: `caller owns`, `borrowed`, or `arena-scoped`.

## Done when
- Word-count demo runs: deterministic sorted output from a map + builder report.
- The key-lifetime trap is demonstrated broken-then-fixed with an explanation.
- Tracking is silent; the map's `delete` frees keys and values with no leftovers.
