# Exercises — Slices & Arrays

## Must implement / demonstrate
1. Fixed-array + slice view: a `[64]u8` (or similar) buffer, a proc taking a `[]u8` view of part of it, output proving the callee sees the caller's bytes.
2. Owned dynamic array lifecycle: `make` with capacity N, `append` to at least 2×N (force regrowth), print `len`/`cap` before and after, `clear` and reuse once, `delete` exactly once.
3. Borrow-vs-own contract: two procs with identical element logic, one taking `[]T` (borrowed, documented no-store) and one taking `^[dynamic]T` or returning an owned clone (documented caller-deletes). Demo calls both.
4. Dangling-trap fix: one deliberately broken version (slice into local/temp returned to caller) plus the fixed version using caller-provided buffer OR owned clone OR arena scope. Keep both, label the broken one clearly, never call it in the happy path.

## Stretch
- Flat 2D grid: `grid_get` / `grid_set` over a single flat allocation with bounds checks; demo a 4×4 fill + print.
- Save a pointer/slice, force regrowth, show it invalidates — then fix the code to re-acquire after `append`.
- Measure: `append` 100k ints with capacity 0 vs pre-sized capacity; record time + peak in your questions file (first benchmark-loop entry).

## Banned / discouraged
- Returning temp-allocator slices to the caller in the happy path.
- `defer delete` inside a loop that appends per iteration (hoist or free explicitly).
- Disabling bounds checks to "fix" an indexing bug.
