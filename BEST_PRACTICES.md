# Best Practices — Living Document

Collect one entry per genuinely useful pattern. Short beats thorough. Each entry: pattern → where seen → why it matters → where applied here.

---

## Template (copy for each entry)
```md
### <short name>
- Seen in: <core:package / paper / own bug>
- Idea: <1–2 sentences>
- Applied: <folder/proc where you used it>
```

---

## Starter entries (edit, extend, dispute)

### Own every allocation
- Seen in: `core:mem`, HOW_TO_PRACTICE Q-MEMORY
- Idea: every non-trivial allocation names its allocator, owner, and death point in a comment.
- Applied: (fill as you go)

### Destroy where you make (or say otherwise)
- Seen in: tracking-allocator discipline
- Idea: the proc/package that `make`s a structure either `delete`s it or documents the transfer in the return contract (`caller owns`, `arena owns`, `borrowed view`).
- Applied: (fill as you go)

### Borrowed vs owned in the name or comment
- Seen in: slice vs dynamic-array confusion
- Idea: procedures returning strings/slices state `borrowed` or `owned (caller deletes)` — no silent third option.
- Applied: (fill as you go)

### Clear vs delete is a design decision
- Seen in: `clear()` keeps capacity, `delete()` frees
- Idea: reusable buffers `clear`; dying structures `delete`. Mixing them causes thrash or leaks.
- Applied: (fill as you go)

### Defer immediately after acquire
- Seen in: file/alloc imu handling
- Idea: write the `defer` on the next line after a successful acquire so the cleanup order (LIFO) mirrors reverse acquisition.
- Applied: (fill as you go)

---

## Rules
- One pattern per entry, max ~6 lines.
- Attribute ideas; re-implement, don't paste.
- Revisit before Phase 7 (GUI) and Phase 10 (productization) — promote what survived, delete what didn't.
