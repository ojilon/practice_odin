# 08 — Torture & Bench Capstone (Pick Your Winners)

> Packages: `ds_cap` (imports your 01–07)  
> Read first: `PRACTICE_LOOPS.md` (benchmark loop), `REVIEW_CHECKLIST.md`

## Why this exists
Seven structures, zero opinions is not done. This capstone tortures everything (allocator swaps, edge storms, leak hunts) and benchmarks the matchups that matter downstream — then writes down which structure wins each future job. Phase 3+ imports the winners; this document is the receipt.

## Steps (simple → complex)
1. Torture harness: one runner that builds each structure, runs its edge matrix (empty/single/full/grow/remove-all/clear-reuse), once on heap+tracking and once on arena-batch (where legal — document where arena is illegal, e.g. mid-life node removal without reclaim). All green, all silent.
2. Swap audit: for each structure, one paragraph — what changed heap→arena (code + teardown), and which structures *refuse* arena cleanly and why.
3. Benchmark suite (same machine + flags throughout, recorded): (a) seq-fill+scan buffer vs list, (b) 1.5x vs 2x growth, (c) set/map at load 0.5/0.7/0.9 (probe or time), (d) queue slice vs linked 100k drain, (e) heap repeated-min vs sort. Five numbers minimum, one `BENCH.md` table.
4. Leak-hunt gallery: 3+ deliberate breaks (skip destroy, use-after-clear, double free or stale-view use), each with the tracking output pasted + the one-line rule. Keep breaks out of the happy path.
5. Winners table: for each downstream job — parser buffer, token dedup, symbol table, undo stack, event queue, frame history, scheduler — name the structure + backing + allocator you will use in Phase 3+, with one reason each. This table is the phase's deliverable alongside green runs.

## Constraints
- Imports 01–07 visibly; no reimplemented clones inside `ds_cap`. Gaps found here become bug fixes in the original folders, not workarounds in the capstone.
- Every number carries machine + build flags + input size. Numbers without context are deleted.
- Broken/failing demos stay labeled and excluded from the happy-path runner.

## Done when
- Torture runner green on heap + arena-where-legal with silent tracking; swap audit written.
- `BENCH.md` (or questions-file table) holds 5+ measurements with context.
- Winners table complete with reuse commitments for Phase 3+; full review checklist passes; `PROGRESS.md` Phase 2 checked off with the sign-off line.
