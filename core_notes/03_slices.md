# Arrays, Slices & Dynamic Arrays

> Read before: `phase_01_core/03_slices_and_arrays`

## Fixed arrays
- `[4]int`, `[16]u8` — length is part of the type, stored inline, no allocation.
- Good for small buffers, headers, inline caches. Copy on assignment (be deliberate with large arrays — pass by pointer/slice).

## Slices
- `[]int` is a `{pointer, length}` view. It does not own memory.
- Slicing never allocates: `s[lo:hi]` just narrows the view. Always ask: who owns the backing memory, and does this slice outlive it?

```odin
buf: [64]u8
view := buf[0:16]  // borrows buf, no allocation
```

## Dynamic arrays
- `[dynamic]int` is `{pointer, length, capacity, allocator}`. `append` may reallocate using the stored allocator.
- The allocator is captured at `make` time (or defaults to `context.allocator`). If you `make` inside a proc with a temp allocator and return the array, you built a dangling bug.

```odin
a := make([dynamic]int, 0, 16)  // uses context.allocator
defer delete(a)
append(&a, 42)
```

## Three ownership shapes (memorize these)
1. **Borrowed slice** — view into someone else's memory. No free. Must not outlive owner.
2. **Owned dynamic array** — someone must `delete` it, exactly once, with the same allocator.
3. **Arena-owned batch** — many arrays/slices freed together with one `free_all`. No per-item delete.

## Bounds & zero values
- Odin bounds-checks indexing in debug/safe builds. Don't disable checks to "go faster" in this dojo — fix the logic.
- `len()` / `cap()` are cheap. Prefer `for x, i in arr` iteration over manual index juggling.

## Preview of deeper ideas (Phase 2 fuel)
- Growth policy (2x vs 1.5x) trades memory waste against copy cost — you will measure this.
- `clear()` keeps capacity; `delete()` frees. Mixing them up is a classic leak-or-thrash bug.
- Multi-dimensional data: prefer one flat allocation + computed indexing over nested dynamic arrays (fewer allocations, friendlier cache).

## Mental model
Arrays are storage, slices are views, dynamic arrays are storage + views + an allocator. Every slice question is a lifetime question; every dynamic-array question is a lifetime + allocator question.
