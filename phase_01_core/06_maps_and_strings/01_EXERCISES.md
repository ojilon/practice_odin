# Exercises — Maps & Strings

## Must implement / demonstrate
1. Map lifecycle: `make(map[string]int)` (explicit allocator), 5+ inserts, lookup of present + absent keys with `(v, ok)` handling, one delete, final `delete(m)`. Print each outcome distinctly.
2. Key-ownership trap: broken version (temp/builder string used directly as key, storage cleared, lookup fails or reads garbage) + fixed version (keys cloned into map allocator, deleted with map). Both labeled; only the fixed one runs in the happy path.
3. Deterministic output: collect keys into a dynamic array, sort (`slice.sort` or hand sort), print `key: count` lines in sorted order. Run twice, show identical output.
4. Builder report: `strings.builder` with pre-sized capacity producing a multi-line summary (totals + top entries); return/emit with a documented ownership contract comment.
5. Word-count: hardcoded paragraph → lowercase/split on whitespace+punct (your rules, documented) → frequency map → sorted builder report. This exact pipeline reappears in Phase 5 — keep it reusable.

## Stretch
- `cstring` boundary: convert one result with `clone_to_cstring`, print it as C-style, free it. Note where the null terminator + ownership live.
- Arena-backed map: whole word-count inside an arena with batch teardown; compare code against the heap version (what got simpler, what got stricter?).
- Duplicate-key + empty-input edges: empty paragraph, all-same-word paragraph, unicode bytes — record behavior.

## Banned / discouraged
- Ignoring the `ok` from map lookup ("zero value means missing" logic).
- Depending on map iteration order for output or tests.
- Returning builder/temp strings to the caller without an ownership comment.
