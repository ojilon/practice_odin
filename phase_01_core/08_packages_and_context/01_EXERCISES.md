# Exercises — Packages & Context (Capstone)

## Must implement / demonstrate
1. Two packages minimum:
   - `p1cap_store`: owned `string → int` table (or your 06 word-count hardened): `store_make`, `store_destroy`, `store_put` (clones keys), `store_get` with `(v, ok)`, allocator-explicit.
   - `p1cap_report`: `report_write(store_view, builder)` producing deterministic sorted output over *borrowed* views (never stores them).
2. Visibility audit: list every public symbol (should fit in ~5 lines); everything else private. Demo imports only public symbols.
3. Context-swap drill: same build+report workload executed under (a) heap, (b) arena (batch free, no per-item deletes), (c) temp + `free_all`. One paragraph each on teardown differences.
4. Logger line: set `context.logger` at startup; emit at least one log line from inside `p1cap_store` or `p1cap_report` without importing the app package.
5. Explicit-context proc: one worker taking an explicit `ctx: runtime.Context` (copied + allocator overridden) instead of inheriting implicitly; comment on when you would choose explicit over implicit.
6. Capstone run: happy path + one error path (bad input or missing key-set) wired end to end, tracking-silent on both, with a reuse comment block citing folders 02–07.

## Stretch
- Third package `p1cap_parse` (tokenizer from 06 extracted cleanly) so the chain is parse → store → report across three packages.
- Thread-shape preview: run the worker twice with two different explicit contexts (heap vs arena) in sequence; document what would need locks if this were parallel (no actual threads required).
- Public-surface review: delete one public proc by folding its logic into an existing one; note what got simpler.

## Banned / discouraged
- Import cycles (fix the boundary instead).
- Package-global mutable allocator or store instance.
- Public symbols that exist "just in case" — every export needs a caller in the demo.
