# Questions — Hashmap

1. State your key-ownership contract verbatim (who clones, who frees, when). What broke in the temp-key version?
   > Your answer:

2. Does your `map_get` return a copy or slot memory? What invalidates it, and what did the stale-pointer demo show?
   > Your answer:

3. Resize checksums: counts + sums across your 2+ resizes? What would a leak or double-free have looked like in tracking?
   > Your answer:

4. Open addressing vs chaining (chosen + compared): why your pick, and what would flip the decision?
   > Your answer:

5. Yours vs builtin `map[K]V`: when do you use which downstream (config, symbol table, hot cache)? One paragraph with reasons.
   > Your answer:
