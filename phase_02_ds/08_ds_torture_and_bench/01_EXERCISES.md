# Exercises — Torture & Bench Capstone

## Must implement / demonstrate (`ds_cap` importing 01–07)
1. Torture runner: single `cap_torture()` proc exercising every structure's edge matrix on heap+tracking (all must pass, tracking silent). Second mode `cap_torture_arena()` running arena-legal cases with batch teardown; arena-illegal cases listed with reasons (not silently skipped).
2. Swap audit: 7 short paragraphs (one per structure 01–07): heap teardown vs arena teardown, code delta, verdict on arena fitness.
3. Benchmark suite with recorded context (machine, `odin` flags, N): minimum five —
   - B1 buffer vs list: 10k fill + scan + sparse remove (time + allocs);
   - B2 growth 1.5x vs 2x vs pre-sized 100k pushes (time + regrows + peak);
   - B3 set/map load 0.5 vs 0.7 vs 0.9 (probe length or time on fixed lookups);
   - B4 queue slice vs linked 100k drain (time + allocs + peak);
   - B5 heap 10k repeated-min vs push-all-then-sort (time).
   Results in `BENCH.md` table + one-sentence takeaway per row.
4. Leak-hunt gallery: 3 deliberate breaks with pasted/summarized tracking output + rule each. Suggestions: skipped `destroy`, temp/arena use-after-clear smuggled into a map key, stale buffer slice used after regrow.
5. Winners table (the deliverable — copy into questions file and cite in Phase 3):

   | Downstream job | Winner (folder+backing) | Allocator | Why (1 line) |
   |---|---|---|---|
   | parser/token buffer | | | |
   | token dedup / seen-set | | | |
   | symbol/config table | | | |
   | undo stack | | | |
   | event/task queue | | | |
   | frame/log history (bounded) | | | |
   | scheduler / frontier | | | |

6. Fix-forward: every gap the torture run finds is fixed in its home folder (01–07), not patched in `ds_cap`; list the fixes with folder + one line each.

## Stretch
- Fuzz-ish storm: deterministic PRNG (fixed seed) random-op mix per structure (push/pop/remove/get interleaved, 50k ops) with invariant checks (len, checksum, sorted-pop for heap); seed recorded so failures replay.
- Memory-ceiling test: bounded structures (06 ring, bounded queue) under 3× overflow proving flat memory + exact drop counts.
- Torture CI shape: `cap_torture()` returns pass/fail bool + prints summary table so a future script (or `tools/verify_dojo.py` sibling) can gate on it.

## Banned / discouraged
- Benchmarks without machine/flags/N.
- Arena-illegal cases silently skipped instead of listed with reasons.
- Fixing home-folder bugs with capstone-side workarounds.
