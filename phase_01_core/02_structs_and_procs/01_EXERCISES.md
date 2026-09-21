# Exercises — Structs & Procs

## Must implement
1. A struct type with at least 3 fields plus:
   - a constructor-style proc returning it by value,
   - an update proc taking `^Your_Struct`,
   - a describe/format proc returning a string or printing it.
2. A `distinct` handle/ID type used in at least one struct field and one proc signature (prove a raw `int` no longer mixes in).
3. An overloaded proc (same name, 2+ signatures — e.g. different arity or types) with a demo calling each overload.
4. A parametric proc using `$T: typeid` (or `$N: int`) instantiated with at least two concrete types, called from the demo.

## Stretch
- Embed a struct with `using` once, then remove it and compare readability — note which you prefer and why.
- Write the same small dataset as AoS and SoA; time a scan over one hot field (see `PRACTICE_LOOPS.md` benchmark loop) and record the result in your questions file.
- Add a second distinct type (units, e.g. pixels vs meters) and push it through one computation.

## Banned / discouraged
- Methods-style hiding: no procedure should mutate a struct passed by value and pretend it worked.
- Single-use generics. Two concrete uses or it stays concrete.
- Large pasted examples — write all types yourself.
