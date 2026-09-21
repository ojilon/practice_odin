# 04 — Hash Set (Open Addressing, Educational)

> Package suggestion: `ds_hashset`

## Why this exists
Dedup, interning, "have I seen this symbol/file/token" — sets answer membership fast. Building one with open addressing + linear probing teaches hashing, load factor, and deletion's dirty secret (tombstones) before the full hashmap in 05 makes them load-bearing.

## Steps (simple → complex)
1. Layout: `Set($T)` with slots array (`occupied / tombstone / empty` states), stored allocator + hasher hook; `set_make(cap_hint, allocator)`, `set_destroy`, `set_len/cap`.
2. Insert/contains: hash → probe → insert-or-found; `set_add -> bool (inserted?)`, `set_contains -> bool`. Demo on 50+ strings/ints with printed load factor.
3. Delete without breaking the probe chain: tombstones. Broken version first (naive empty-on-delete, lookup fails past the hole — labeled), then tombstone fix with probe tests crossing deleted slots.
4. Resize: grow + rehash at load ~0.7 (measure why: probe-length stats before/after). Print regrow events like folder 01 did.
5. Practical pass: dedup a hardcoded token list (or file lines) preserving first-seen order via your 01 Buffer + this set; report unique count + duplicates dropped.

## Constraints
- Hasher is injectable or documented per type (default: builtin hash for the demo types; custom types need an explicit hash proc — no magic).
- Deletion uses tombstones (or documented backward-shift). Naive blanking is allowed exactly once, labeled broken, to prove the probe-chain bug.
- Load factor visible: every demo prints `len/cap/load` at key points; resize threshold stated in a comment.

## Done when
- Insert/contains/delete/resize all correct across the probe chain, including lookups that cross tombstones.
- Dedup demo works with order preserved and duplicates counted.
- Probe-length or timing note at high vs low load factor; builtin-comparison paragraph.
