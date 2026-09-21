# 08 — Packages & Context (Phase 1 Capstone)

> Prerequisite: `core_notes/06_errors_context.md` (packages + context sections)  
> Packages: `p1cap/*` (2–3 small packages you design)

## Why this exists
Phase 1 ends with a multi-file, multi-package program that uses *everything*: structs, slices, arenas, maps/strings, errors, and the context system on purpose. This is the rehearsal for Phase 2's allocator-taking structures and Phase 5's composed tools.

## Steps (simple → complex)
1. Split: design two packages — e.g. `p1cap_store` (an owned string→int table with explicit allocator + destroy) and `p1cap_report` (builder-based sorted report over borrowed views). No import cycles; shared types go in the lower package.
2. Privatize: mark every helper private except the minimal public surface (create/destroy/insert/lookup + one report proc). The demo must compile against only the public surface.
3. Context drill: run the same workload three ways — default heap context, arena-backed context (batch teardown), temp context with clear point — by setting `context.allocator` before the call. Document what the callee code did *not* need to change.
4. Logger + explicit pass: set `context.logger` once, log one line from inside a library package (no app import), and pass an explicit `ctx := context` into one worker proc to show the auditable form.
5. Capstone demo: one `main`-called proc that wires store → error paths → report, runs happy + one error path, and ends tracking-silent with ownership comments on every type.

## Constraints
- Acyclic imports, private-by-default, no cross-package field poking (use procs).
- Allocator flows through `context` or explicit param — never a package-global allocator variable.
- This folder reuses folders 02–07 visibly: cite which idea came from where in one comment block.

## Done when
- Two (or three) packages compile together with a minimal public surface and zero cycles.
- The context-swap drill runs three ways with a paragraph on what changed vs what didn't.
- Full review checklist passes; sign-off line cites reuse (`02 structs`, `03 slices`, `05 arena`, `06 maps`, `07 errors`).
- You are ready for Phase 2: every structure there takes an allocator because you now expect it to.
