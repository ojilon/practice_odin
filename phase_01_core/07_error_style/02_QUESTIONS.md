# Questions — Error Style & Defer

1. When do you use `or_return`, when do you handle explicitly, and when do you add context? Give one example of each from your demo.
   > Your answer:

2. What does `defer` guarantee about order, and why does "defer on the next line after acquire" matter? Show your acquire/defer pairs.
   > Your answer:

3. What leaked in the broken version, and what exactly fixed it — which return path skipped what?
   > Your answer:

4. Paste or summarize the tracking report for all three paths (happy + 2 errors). Why must error paths be tracking-clean too?
   > Your answer:

5. Which of your errors are recoverable vs fatal, and where is that decision made (callee vs caller)?
   > Your answer:
