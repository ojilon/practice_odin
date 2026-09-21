# Exercises — Error Style & Defer

## Must implement / demonstrate
1. Domain error type: an enum (or union) with 3–5 cases for one tiny domain (parse int list, open+read config, etc.) + a fallible proc returning `(value, err)`.
2. Three-path demo: happy path, error path A (bad input), error path B (missing resource / out-of-range). Each prints a distinct, actionable message. All three run from the demo.
3. `or_return` chain: at least two layers propagating with `or_return`, with added context at exactly one boundary (wrap with input name / step, not at every layer).
4. Defer-pair proof: two acquisitions with immediate defers; forced error between use and scope exit; tracking report proving both released on the error path.
5. Leak-trap pair: broken version (early return skipping a free — show the tracking complaint) + fixed version (defer-first or explicit free before every return). Labeled; broken never runs in the happy path.

## Stretch
- Error-context helper: one small wrapper that prefixes operation + input (e.g. `parse_users("x.csv"): line 3: ...`) without ballooning every call site.
- Retry-or-fail decision: one error you retry (or fall back) vs one you propagate immediately — document the rule.
- Real file I/O: `os.read_entire_file` on present + missing files with allocator-explicit handling (`delete` the bytes, propagate the error).

## Banned / discouraged
- Panicking on expected input errors.
- Swallowing errors (`_ = err` or ignoring the second return) without a comment explaining why it is safe.
- One giant global error enum covering unrelated domains.
