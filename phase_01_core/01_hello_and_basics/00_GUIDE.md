# 01 — Hello and Basics

> Package suggestion: `hello_basics` or simply work in a package named after the folder.  
> Prerequisite: `core_notes/01_basics.md`

## Why this exists
Confirm that your environment works and that you can write and run the simplest Odin programs. Establish the habit of a scratch entry point and a dedicated package for exercises.

## Steps
1. Create a package that exports a few simple procedures (greet, add, etc.).
2. From a root scratch `main.odin`, import and call them.
3. Experiment with `fmt.println` / `fmt.printf` and basic types.
4. Make sure you can compile and run cleanly.

## Constraints
- No complex memory work yet — that comes in folder 04.
- Keep the code small and readable.

## Done when
- You have a package with at least two exported procedures.
- A root main calls them and prints visible output.
- `odin run .` (or your equivalent) succeeds.
- You feel comfortable creating a new package directory and importing it.
