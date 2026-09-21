# Structs, Procs & Polymorphism

> Read before: `phase_01_core/02_structs_and_procs`

## Structs
- Plain data by default. No methods, just procedures that take them.
- Prefer explicit initialization over hidden constructors.
- `using` embeds a struct's fields into the outer struct — convenient, but don't overuse; it hides where fields live.

```odin
Vec2 :: struct { x, y: f32 }
move :: proc(v: ^Vec2, dx, dy: f32) { v.x += dx; v.y += dy }
```

- Pass small structs by value, large or mutated structs by pointer (`^T`). If a proc mutates, the `^` in the signature is your documentation.

## Distinct types
- `distinct` creates a new type that does not implicitly convert — use it for handles, IDs, units.

```odin
Entity_Id :: distinct int
Meters    :: distinct f32
```

- This catches unit/handle mixups at compile time. Prefer it over bare `int` for any ID that crosses package boundaries.

## Overloading & parametric (generics)
- Multiple procs with the same name but different signatures overload; Odin picks by call-site types.
- Parametric procs use `$T: typeid` (type) or `$N: int` (value) parameters for compile-time specialization.

```odin
sum :: proc(a: $T) -> T { ... }  // sketch — real version constrains T
```

- Rule of thumb for this dojo: reach for parametric code only when you have 2+ concrete uses. One generic nobody reuses is worse than two clear concrete procs.
- The built-in dynamic array, map, and `slice` package are all parametric — you will mirror that pattern in Phase 2.

## SoA vs AoS (preview)
- Array-of-structs (AoS) is the default and reads well.
- Struct-of-arrays (SoA, e.g. `#soa` annotation or manual split) wins when you iterate one hot field over many elements.
- You don't need SoA in Phase 1. Just notice which shape your loops actually touch — Phase 2 and the GUI phase will revisit this.

## Mental model
Odin procs are functions with clear inputs. Structs are layouts with clear ownership. `distinct` + overloads + `$T` let you stay explicit without repeating yourself.
