# 04 — Memory Intro (Allocators & Tracking)

> Prerequisite: `core_notes/04_memory.md`  
> This is one of the most important early folders.

## Why this exists
Odin’s power and discipline come from explicit allocation. Here you learn the default allocator, the temporary allocator, and the tracking allocator so that leaks and bad frees become visible.

## Steps (simple → complex)
1. Allocate a few values with `new` and `make` using the default context allocator; free them deliberately.
2. Use the temporary allocator for short-lived data and call `free_all` at a clear point.
3. Install the tracking allocator in a debug build and intentionally create a leak; observe the report.
4. Fix the leak and confirm the tracking allocator is quiet on the happy path.
5. Write a short comment in your code explaining who owns each allocation.

## Constraints
- Prefer the real `core:mem` facilities; do not reimplement allocators yet (that comes next).
- Always run with tracking enabled while developing this folder.

## Done when
- You can allocate, free, and use the temp allocator correctly.
- The tracking allocator reports zero leaks and zero bad frees for your demo path.
- You can explain, in your own words, what `context.allocator` is and why the temp allocator exists.
