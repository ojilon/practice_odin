# Questions — Maps & Strings

1. Who owns a map's keys and values, and when are they freed? What did you clone vs borrow in your word-count?
   > Your answer:

2. What went wrong in the broken key-lifetime version, exactly (whose memory died, when, and why did the lookup fail)?
   > Your answer:

3. Why is map iteration order unspecified, and what did you do to make your output deterministic?
   > Your answer:

4. What is the ownership contract on each string your code returns (`caller owns` / `borrowed` / `arena-scoped`)? List them.
   > Your answer:

5. What is the difference between `string` and `cstring`, and where does the conversion allocate?
   > Your answer:
