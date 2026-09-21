# Practice Loops — How Growth Actually Happens Here

The roadmap gives you *what* to build. This file gives you *how* to repeat it until it sticks.

Pick at most one loop per day. Fifteen focused minutes beats an hour of drifting.

---

## 1. Kata loop (15–25 min, any phase)
Re-implement something you already built, from a blank file, without looking:
- Phase 1: `append`-like grow, arena reset, builder join.
- Phase 2: ring-buffer push/pop, heap sift-up/down, linked-list remove.
- Later: tokenizer pass, layout row/column, gap-buffer move-gap.

Rules: timer on, tracking allocator on, no peeking for the first 10 minutes. When stuck, note *exactly* where, then look. The note is the lesson.

Done when: it compiles, tracking is silent, and you can explain each line without the reference open.

## 2. Allocator-torture loop (10–20 min, from Phase 1/04 onward)
Take any working demo and run it three ways:
1. Backed by heap + tracking — expect silence.
2. Backed by a fresh arena (whole demo inside, single `free_all`) — expect silence, no per-item frees.
3. Backed by temp allocator with `free_all` at the end — expect silence *only* if nothing escapes.

Then deliberately break one thing (skip a free, use-after-clear, double free) and read the tracking report. You are training your eyes to recognize each failure signature.

## 3. Benchmark loop (20–30 min, from Phase 2 onward)
One question, one measurement, one decision. Template:
- Question: "Does 1.5x vs 2x growth matter for 100k appends?" / "Does SoA beat AoS for this scan?"
- Method: `time` package, N iterations, same machine, note build mode (`-o:speed` vs debug).
- Record: input size, time, peak allocation (tracking or arena stats), conclusion in one sentence.

Keep results in the exercise folder's `02_QUESTIONS.md` answer box or a `BENCH.md` next to it. No benchmark survives without the machine + flags noted.

## 4. Reading loop (20–40 min, weekly — see EXPLORATION.md)
Read one small thing fully instead of five things partially:
- One `core:` procedure (trace every branch).
- One paper section (implement the smallest figure).
- One Win32 sample (message loop, GDI rect, file mapping).

Output: 5–10 lines in `PROGRESS.md` or `BEST_PRACTICES.md` — what it does, what allocator/lifetime choice it makes, what you will steal or reject.

## 5. Bug-journal loop (5 min after every bug)
Every bug that cost you >10 minutes gets one entry (in the folder's questions file or `PROGRESS.md`):
- Symptom → root cause → fix → one rule that prevents recurrence.

Examples worth collecting: dangling temp slice, forgotten `delete`, growth invalidating a saved pointer, off-by-one in ring wrap, heap parent/child index math.

## 6. Review loop (before marking any folder done)
Run `REVIEW_CHECKLIST.md` top to bottom. If any box fails, the folder is not done — the checklist is the definition of done, not your optimism.

---

## Weekly rhythm (suggestion, ~1–2h most days)
- 3–4 days: current roadmap folder (forward progress).
- 1 day: kata or allocator-torture on an *older* folder (retention).
- 1 day: reading loop + bug-journal grooming (fuel).
- Milestone weeks: benchmark loop + README polish (shipping).

Growth = forward work × retention loops × shipping. Miss any factor and progress stalls.
