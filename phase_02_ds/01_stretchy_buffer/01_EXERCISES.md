# Exercises — Stretchy Buffer

## Must implement (`ds_buffer` package, parametric `$T`)
1. `Buffer($T)` struct: backing storage + `len`/`cap` queryable + stored `allocator: mem.Allocator`.
2. `buf_make($T, cap: int, allocator := context.allocator)`, `buf_destroy`, `buf_clear` (keeps capacity), `buf_len`, `buf_cap`.
3. `buf_push(b: ^Buffer($T), v: T)` with documented growth policy; demo prints every regrow (old cap → new cap) over 0→200 pushes.
4. `buf_push_slice(b, vs: []T)` — single growth for N items; `buf_pop(b) -> (T, bool)`; `buf_remove(b, idx) -> bool` with documented order semantics (swap vs shift — pick one, document it).
5. `buf_slice(b) -> []T` (borrowed view) + invalidation comment; broken-stale-view demo (labeled) + fixed re-acquire version.
6. Policy benchmark: 100k pushes under (a) growth 2x from 0, (b) growth 1.5x from 0, (c) pre-sized exact. Record wall time + regrow count + peak bytes.

## Stretch
- `buf_reserve` (pre-grow without changing len) + `buf_shrink_to_fit`; prove with len/cap prints.
- Caller-provided-buffer constructor (no allocation at all) for hot paths; document when it refuses (overflow → bool/error, never silent).
- SoA flavor: parallel `xs, ys: Buffer(f32)` vs `Buffer(Vec2)` scan benchmark; one-sentence verdict in questions file.

## Banned / discouraged
- Destroying with the wrong allocator (must use stored allocator).
- `buf_pop`/`buf_remove` on empty silently returning zero values — always signal emptiness.
- Hiding regrow cost: the demo must surface when copies happen.
