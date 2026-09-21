# Exercises — Memory Intro

## Must implement / demonstrate

1. Allocate an integer and a dynamic array with the default allocator; free/delete them properly.
2. Use `context.temp_allocator` for a temporary slice or string; clear it with `free_all`.
3. Wrap your demo with a `Tracking_Allocator` (debug) and show that a deliberate leak is detected.
4. Remove the leak and show a clean tracking report.

## Stretch
- Allocate a small struct, store it in a dynamic array, and free everything in the correct order.
- Experiment with changing `context.allocator` for a nested procedure call and observe inheritance.

## Banned / discouraged
- Do not ignore tracking allocator output.
- Do not leave allocations without a clear free path in the happy-path demo.
