# Review Checklist — Definition of Done (per folder)

Run this before checking off any folder in `PROGRESS.md`. Be honest; future-you inherits every shortcut.

## Must pass
- [ ] **Builds clean:** `odin run .` (or package build) succeeds; no warnings you don't understand.
- [ ] **Tracking silent:** happy-path demo under `mem.Tracking_Allocator` reports zero leaks and zero bad frees. (Paste or summarize the report in the questions file.)
- [ ] **Ownership written:** every owning type documents allocator + who calls destroy + what invalidates outstanding views (grow/clear/destroy). A comment at the type is enough.
- [ ] **Required symbols exist:** everything in `01_EXERCISES.md` "Must implement" is present with the specified names/behavior.
- [ ] **Demo runs:** the folder's demo procedure prints or shows the behavior end-to-end (not just "it compiles").
- [ ] **Questions answered:** all boxes in `02_QUESTIONS.md` filled in your own words, with observed output where asked (not theory).
- [ ] **Reuse cited:** note which earlier package you reused (or why you deliberately chose the builtin instead). One line is enough.

## Should pass (fix or justify)
- [ ] **No hidden allocations:** you can name the allocator behind every `make`/`new`/`append`/builder/clone in the demo.
- [ ] **Edge cases probed:** empty, single-element, full/grow, not-found, and clear-then-reuse paths all exercised at least once.
- [ ] **Stretch or spike:** at least one stretch goal attempted, or a 2-sentence note on why it was out of scope this pass.
- [ ] **Benchmark or torture (Phase 2+):** one measurement or one allocator-swap run recorded.

## Must NOT have
- [ ] No solution code pasted from external projects (ideas + attribution OK, wholesale copy no).
- [ ] No temp-allocator value escaping its clear point.
- [ ] No `defer` inside a hot loop accumulating to scope exit.
- [ ] No committed binaries, no secrets, no `.local.md` scratch (see `.gitignore`).

## Sign-off line
Add one line to the folder's questions file or `PROGRESS.md`:

> `DONE <folder> — tracking clean, demo <name> runs, reuse: <package or builtin+reason>`

If you can't write that line truthfully, keep working.
