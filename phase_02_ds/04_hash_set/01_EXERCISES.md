# Exercises — Hash Set

## Must implement (`ds_hashset`, parametric `$T` + explicit hasher)
1. `Set($T)`: slots with 3-state occupancy, stored allocator; `set_make(cap_hint, allocator)`, `set_destroy`, `set_add(v) -> bool`, `set_contains(v) -> bool`, `set_remove(v) -> bool`, `set_len/cap/load_factor`.
2. Hasher contract: document how `T` hashes + compares (which proc, who provides it for a new type). Demo instantiates for at least `string` and one integer/small-struct type.
3. Tombstone pair: broken `remove` (blank slot, probe chain breaks — failing lookup demo, labeled) + fixed tombstone `remove` with lookups crossing 3+ deleted slots proven in output.
4. Resize: automatic grow+rehash when load exceeds stated threshold (suggest 0.7); demo inserts past threshold, prints regrow + probe stats before/after.
5. Dedup application: hardcoded list (tokens, lines, or IDs, 30+ items with known duplicates) → unique-in-first-seen-order via Set + `01` Buffer; print uniques + dropped count.
6. Edge matrix: empty set ops, duplicate adds, remove-missing, remove-all-then-reinsert, clear-then-reuse — each with expected vs observed.

## Stretch
- Probe statistics: histogram of probe lengths at load 0.5 / 0.7 / 0.9; one-sentence rule for sizing from data.
- Backward-shift deletion (no tombstones): implement as alternative, compare code complexity + probe behavior vs tombstones.
- Custom type: a small struct key (e.g. 2D point or token) with hand-written hash + eq; show a collision-heavy workload still correct.

## Banned / discouraged
- Shipping naive blank-on-delete as the real implementation.
- Unspecified hasher ("it just hashes") — the contract is part of the deliverable.
- Hiding load factor; every growth decision must be visible in output.
