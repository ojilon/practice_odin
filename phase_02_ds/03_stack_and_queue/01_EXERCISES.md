# Exercises — Stack & Queue

## Must implement (`ds_stack_queue`, parametric, reusing folders 01–02)
1. `Stack_Slice($T)`: `stack_make/destroy/push/pop -> (T,bool)/peek -> (T,bool)/clear/len` backed by `01` Buffer. Import it; don't reimplement growth.
2. `Stack_Linked($T)`: same interface backed by `02` list (or local nodes with stored allocator). Same workload as #1 for comparison.
3. `Queue_Slice($T)`: `queue_make/destroy/enqueue/dequeue -> (T,bool)/peek/len` with head-index + documented drift policy (compact threshold or ring — state it, implement it).
4. `Queue_Linked($T)`: front/back O(1) both ends, same interface as #3.
5. Workload comparison: 10k enqueue+dequeue (queue) and 10k push+pop (stack) on both backings; record time + allocation counts + verdict line per structure.
6. Real-use demo: (a) bracket-matcher (`()[]{}`, reports first mismatch position or OK) on 3+ inputs incl. empty + malformed; (b) FIFO task drain (enqueue 5 named tasks, dequeue in order, handle empty dequeue gracefully).

## Stretch
- Bounded stack/queue: fixed-capacity variant returning `false`/error on overflow instead of growing — direct preview of `06` ring semantics; say which later system wants bounded (input events, audio).
- Undo sketch: push full snapshots (or deltas) of a tiny integer/string document, pop to restore, `clear` on new branch; document snapshot-vs-delta trade.
- Min-stack: O(1) `min` alongside push/pop (auxiliary stack or stored minima); prove with interleaved push/pop/min prints.

## Banned / discouraged
- Panicking on underflow/empty in demo code.
- Rewriting growth or node logic instead of importing 01/02 without a written reason.
- Slice-queue with unbounded head drift (memory grows forever on long drain).
