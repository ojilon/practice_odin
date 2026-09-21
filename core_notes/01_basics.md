# Basics — Packages, Procedures, Types, Printing

## Packages
- A package is a directory of `.odin` files that all declare the same `package name`.
- `import "core:fmt"` brings in the core formatting package.
- Package names must be unique in the project.

## Procedures
```odin
add :: proc(a, b: int) -> int {
    return a + b
}
```
- `main :: proc()` is the entry point for an executable package.

## Basic types
- Integer types (`int`, `i32`, `u64`, …), floats, `bool`, `rune`, `string`, `cstring`.
- `string` is a slice of bytes (length + pointer); it does not own memory by itself.

## Printing
```odin
import "core:fmt"
fmt.println("hello", 42)
fmt.printf("value = %d\n", 42)
```

## Mental model
Odin is explicit. Prefer clear names and direct code over cleverness. Memory is not hidden — that becomes central in the next notes.
