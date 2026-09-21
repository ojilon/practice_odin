# Questions — Arenas & Custom Allocators

1. When does an arena beat per-item `new`/`delete`, and when does it lose? Give one concrete example of each from your demos.
   > Your answer:

2. What does the `mem.Allocator` interface actually require of your custom proc (arguments, alignment, zero-size, resize/free semantics)?
   > Your answer:

3. What broke in your escape-after-clear version, and what rule prevents it in real code?
   > Your answer:

4. Heap vs arena vs your wrapper: what changed in code, what changed in performance/behavior, and which would you pick for (a) a file parser, (b) a per-frame GUI scratch, (c) long-lived editor buffers?
   > Your answer:

5. Draw or describe the lifetime diagram of your arena demo: allocation points, the single free point, and every invalidation event.
   > Your answer:
