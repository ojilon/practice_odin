# 03 — Slices & Arrays

> Prerequisite: `core_notes/03_slices.md`  
> Package suggestion: `slices_arrays`

## Why this exists
Borrowed views vs owned storage is the bug factory of every later phase. Get it right here on small arrays and the Phase 2 structures, parsers, and GUI buffers all get easier. Get it wrong here and you will chase dangling slices for months.

## Steps (simple → complex)
1. Fixed array: declare, fill, pass a slice-view of part of it into a proc. Confirm no allocation happens.
2. Borrowed slice: write a proc taking `[]T` that never stores it past the call. Document the borrow in a comment.
3. Owned dynamic array: `make` with an explicit capacity, `append` past it (watch growth), `clear` + reuse, then `delete`. Each step prints `len`/`cap`.
4. Lifetime trap (deliberate, then fixed): return a slice into a local/temp buffer, observe the garbage under the tracking allocator or by inspection, then fix it with one of: caller-provided buffer, owned clone, or arena scoping.
5. Flat 2D: represent a grid as one flat `[dynamic]T` with `idx = y*w + x` helpers instead of nested arrays.

## Constraints
- Every dynamic array in the demo has exactly one `delete` on the happy path (or a documented arena owner).
- No slice outlives its owner. If a proc returns a slice, the comment says what owns the backing memory.
- Run everything under the tracking allocator (`common/dojo_debug` helper recommended).

## Done when
- The demo prints len/cap transitions through make → append/grow → clear → delete.
- You can explain, without notes, the three ownership shapes (borrowed slice / owned dynamic / arena batch) with one example of each.
- Tracking reports zero leaks and zero bad frees on the fixed demo.
