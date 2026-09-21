# Questions — Hash Set

1. Why does naive blank-on-delete break lookups? Walk through one probe chain from your broken demo.
   > Your answer:

2. Tombstones vs backward-shift (if tried): how does each keep the chain intact, and what does each cost over time?
   > Your answer:

3. Probe stats at the load factors you measured? What resize threshold did you choose and why?
   > Your answer:

4. What is the hasher contract for a new type `T`, and what did your string + second-type instantiations each use?
   > Your answer:

5. Dedup results (uniques, dropped)? Where downstream (interning, symbol sets, file dedup) will you reuse this set?
   > Your answer:
