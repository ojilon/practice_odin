# Memory & Allocators (critical)

Odin has no garbage collector. Allocation is done through **allocators** that live in the `context`.

## Key ideas
- `context.allocator` is the default for `new`, `make`, `delete`, etc.
- You can temporarily change the context allocator; called procedures inherit it.
- The **temp allocator** is an arena that you clear (`free_all`) at well-defined points (e.g. end of frame or end of request).
- The **tracking allocator** records every allocation and reports leaks / bad frees. Use it in debug builds.

## Common pattern (debug)
```odin
import "core:mem"

when ODIN_DEBUG {
    track: mem.Tracking_Allocator
    mem.tracking_allocator_init(&track, context.allocator)
    context.allocator = mem.tracking_allocator(&track)
    defer {
        // inspect track.allocation_map and bad_free_array
        mem.tracking_allocator_destroy(&track)
    }
}
```

## Arenas
Arenas give you bulk allocation with a single free point. Excellent for temporary data with clear lifetimes.

## Ownership
When you design a data structure, decide:
- Which allocator owns the memory?
- Who is responsible for calling the destroy / free procedure?
- Can the structure outlive the current scope?

Write these decisions down in comments or documentation for any non-trivial type.

## Resources
- `core:mem` source and documentation
- Ginger Bill’s writings on memory allocation strategies
- The tracking allocator implementation itself
