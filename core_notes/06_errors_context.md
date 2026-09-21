# Errors, Defer & the Context System

> Read before: `phase_01_core/07_error_style` and `08_packages_and_context`

## Error style (no exceptions)
- Odin uses multiple return values + `or_return` / `or_else` / explicit checks. Errors are values, not control-flow hijacks.
- Convention: `value, err := do_thing(); if err != nil { ... }`. `or_return` propagates to the caller's error return — use it when you have nothing useful to add at this level.

```odin
data, err := os.read_entire_file(path, context.allocator)
if err != nil { return err }
defer delete(data)
```

- Design your error values as narrow enums/unions per package, not one giant global. Callers should be able to match on what they can handle and propagate the rest.
- Wrap with context (which file? which phase?) at boundaries where the extra info actually helps debugging — not at every single layer.

## Defer
- `defer` runs at scope exit, LIFO. It is the primary cleanup tool: frees, closes, unlocks, arena pops.
- Order matters: acquire A then B → `defer` B's cleanup first (LIFO does this naturally if you defer immediately after each acquire).
- Don't defer inside a hot loop (accumulates until scope exit). Free explicitly per iteration or hoist the loop into its own proc so defers fire per call.

## The context system (deeper than "global allocator")
- `context` is an implicitly-passed struct: allocator, temp allocator, logger, assertion handler, random state, user data, and more.
- Called procedures inherit the caller's context — that is why setting `context.allocator` before a call changes what `new`/`make` inside that call use.
- `context.temp_allocator` is a scratch arena per thread/scope; `free_all` it at frame/request end. Never store temp results past that point.
- `context.logger` lets libraries log without importing your app's logger — set it once at startup.

```odin
ctx := context  // copy
ctx.allocator = my_arena_allocator()
do_work(ctx)    // explicit context pass — preferred for jobs/threads
```

- Prefer explicit `context` passing for background work, threads, and any code that outlives the current scope. Implicit inheritance is convenient; explicit passing is auditable.

## Packages & visibility
- One directory = one package; all files in it share the `package name`.
- `Private` (capital P annotation / `private` keyword per Odin version — check current docs) restricts a symbol to its package. Default to private; export only the small surface callers need.
- Cross-package imports must be acyclic. If two packages need each other, the boundary is wrong — extract a third package or merge.

## Mental model
Errors are return values with discipline, `defer` is scoped cleanup with order, `context` is ambient capability with inheritance. All three reward the same habit: say who owns what, and clean up exactly where you acquired.
