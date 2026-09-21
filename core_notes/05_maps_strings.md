# Maps, Strings & Builders

> Read before: `phase_01_core/06_maps_and_strings`

## Maps
- `map[K]V` is a hash map provided by the language/runtime. `make` with an allocator, `delete` when done.
- Lookup returns `(value, found)`. Always handle the not-found case explicitly — silent zero values cause real bugs.

```odin
m := make(map[string]int)
defer delete(m)
m["odin"] = 1
v, ok := m["missing"]
```

- Key lifetimes matter: a `string` key does not copy itself into the map unless you allocate it there. String literals are fine (static); slices into a temp buffer are not (dangling keys).
- Iteration order is unspecified. Never depend on it; if you need sorted output, collect keys and sort.
- You will build your own hash set / hash map in Phase 2 — not because the builtin is bad, but so you understand probing, load factor, and tombstones from the inside.

## Strings
- `string` = `{pointer, length}`, immutable-by-convention view over bytes. It owns nothing by itself.
- `cstring` = null-terminated pointer for C/Win32 interop. Convert deliberately at API boundaries (`strings.clone_to_cstring`, etc.).
- `strings.builder` accumulates output efficiently; `strings.clone` / `strings.concatenate` allocate with an explicit allocator.

## Builder discipline
- One builder per output, reset or destroy it at a clear point. Don't share a builder across unrelated outputs.
- For hot paths, `make` the builder with a known capacity to avoid regrowth; for throwaway formatting, the temp allocator is fine.
- When a procedure returns a `string`, document who frees it: caller-owned clone (caller deletes) vs borrowed view (no free) vs arena-scoped (dies with arena).

## Common traps
1. Storing a temp-allocator string past `free_all` — instant garbage.
2. Using a slice of a builder's buffer after further writes reallocate it.
3. Comparing strings with `==` is fine (content compare); comparing `cstring` pointers is not.

## Mental model
Maps trade memory for O(1)-ish lookup; strings trade ownership clarity for convenience. In both cases the dojo question is the same: who allocated the bytes, and when do they die?
