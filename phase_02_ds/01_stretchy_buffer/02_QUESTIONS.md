# Questions — Stretchy Buffer

1. What growth policy did you implement, and what did 1.5x vs 2x vs pre-sized measure (time, regrows, peak)? Machine + flags?
   > Your answer:

2. What invalidates a `buf_slice` view, and how did your broken demo prove it? What is the fix rule?
   > Your answer:

3. `clear` vs `destroy` vs `shrink_to_fit` (if built): what does each preserve or release, and when do you pick each?
   > Your answer:

4. What does the builtin `[dynamic]T` (or `core:container`) do better than your buffer, and when would you still use yours?
   > Your answer:

5. Bug journal: the most expensive bug in this folder — symptom → cause → rule that prevents it.
   > Your answer:
