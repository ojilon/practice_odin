# Exercises — Hashmap

## Must implement (`ds_hashmap`, `$K` + `$V` parametric, ≥2 value types in demo)
1. `Map($K,$V)`: `map_make(cap_hint, allocator)`, `map_destroy` (frees keys per contract + table), `map_put(k, v)`, `map_get(k) -> (V, bool)` with documented copy-vs-pointer semantics, `map_remove(k) -> bool`, `map_len/cap/load`, `map_clear`.
2. Key-ownership contract (in code comment + demo): string/slice keys cloned on put with map allocator, freed on remove/destroy; broken temp-key version (labeled) + fixed clone version.
3. Resize proof: insert 500+ entries from empty, survive ≥2 automatic resizes; checksum (entry count + value sum) printed before/after each resize, all lookups verified after.
4. Stale-pointer rule: if `map_get` (or a pointer variant) exposes slot memory, demonstrate invalidation across a resize (labeled) and state the rule (re-get after any put that may grow).
5. Config-table demo: 10+ hardcoded `key=value` lines → parse → put; lookups (2 hits incl. case from 06-style strings, 1 miss with clean message); one remove + re-get proving absence; sorted key dump via `01` Buffer + sort.
6. Edge matrix: duplicate put (overwrite semantics stated + proven), remove-missing, clear-reuse, empty-map get, many-collision workload (small table forced) all correct.

## Stretch
- Chained-bucket alternative: implement or sketch separate chaining beside open addressing; compare deletion simplicity vs cache behavior in one paragraph with a small measurement.
- `map_keys_into(buf)` helper emitting keys into a caller buffer (no allocation inside) for sorted dumps — zero-alloc iteration pattern.
- Arena-mode map: whole map + keys in an arena, batch teardown, no per-key frees; document which operations become illegal (mid-life remove can't reclaim) and which app still fits.

## Banned / discouraged
- Storing borrowed temp keys in the happy path.
- Returning slot pointers without an invalidation contract.
- Ordered output depending on probe/iteration order instead of explicit sort.
