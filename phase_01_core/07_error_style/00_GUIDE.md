# 07 — Error Style & Defer

> Prerequisite: `core_notes/06_errors_context.md` (errors + defer sections)  
> Package suggestion: `error_style`

## Why this exists
Odin has no exceptions. Real programs thread errors through return values and clean up with `defer`. Sloppy error paths leak memory and hide root causes; disciplined ones make Phase 5 tools and Phase 8 file I/O boring in the good way.

## Steps (simple → complex)
1. Fallible proc: define an error enum/union for one tiny domain (e.g. parse/config), write a proc returning `(T, Err)`, handle both paths in the caller.
2. `or_return` propagation: chain 2–3 fallible calls where the middle layers add nothing — propagate with `or_return`, and add context (which input? which step?) exactly once at the boundary where it helps.
3. Defer discipline: acquire two resources (memory + file handle, or two allocations), `defer` each cleanup immediately after acquire, force an error between them, prove both clean up (tracking silent even on the error path).
4. Error-path leak trap: broken version where an early return skips a free, then the fixed version. Run both under tracking; keep the broken one labeled and out of the happy path.
5. Design pass: narrow your error type to what callers can actually handle; propagate the rest. Document which errors are recoverable vs fatal for your demo.

## Constraints
- No panics for expected failures (missing file, bad input, not-found). Panics are for programmer bugs only.
- Every acquire has its `defer` on the next line. No deferred cleanup written three pages below the acquire.
- No `defer` inside a hot loop — free per iteration or extract the iteration into a proc.

## Done when
- Happy path and at least two error paths (e.g. bad input + missing resource) all run, all print a clear message, and tracking is silent on *all three*.
- You can state when to use `or_return` vs explicit handling vs adding context.
- The leak-trap pair exists with an explanation of what the early return skipped.
