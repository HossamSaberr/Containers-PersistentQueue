# Containers-PersistentQueue

A purely functional Persistent Queue for Pharo, providing **$O(1)$ amortized time** and **$O(1)$ space** per operation. Every modification returns a new queue instance while preserving all previous versions, enabling infinite state branching and efficient version history.

*(Note: "Persistent" in this context refers to Functional Persistence maintaining historical immutable states in memory, not saving to a database or disk.)*

![Pharo 14+](https://img.shields.io/badge/Pharo-14%2B-informational) ![License MIT](https://img.shields.io/badge/License-MIT-success)

---

## What is a Persistent Queue?

A **standard queue** changes its data in place. When you add or remove an item, the previous version of that queue is gone forever. To save every version of a standard queue (for an "Undo" system or to track history), you would have to copy the entire queue every time it changes. This is very slow and fills up your memory quickly.

This **Persistent Queue** solves that problem. Every time you modify it, the library creates a new version of that queue while preserving every previous version. It does this without copying the whole queue; it simply shares the existing data already in memory. 

This library implements the **Two-Stack Architecture**. Instead of mutating an array, the queue is composed of two purely functional, singly-linked stacks (`frontStack` and `rearStack`). 

Because nodes are never mutated, multiple queue versions can safely share the same nodes in memory (Structural Sharing). Enqueuing creates a new timeline branch in strict $O(1)$ time by pointing a single new node at the shared history.

```text
       [ Branch A: enqueue 'B' ]
              (Val: 'B') 
                  \
                   \ pointer
                    v
                 (Val: 'A')  <---- [ Base State: enqueue 'A' ]
                    /
                   / pointer
                  /
              (Val: 'C')
       [ Branch B: enqueue 'C' ]
```
*Three separate queues exist simultaneously. All three share node 'A' in memory. No deep copying is required.*

---

## Loading

To install `Containers-PersistentQueue`, open the Playground (`Ctrl + O + W`) in your Pharo image and execute the following Metacello script (select it and press Do-it or `Ctrl+D`):

```smalltalk
Metacello new
  baseline: 'ContainersPersistentQueue';
  repository: 'github://pharo-containers/Containers-PersistentQueue/src';
  load.
```

### If you want to depend on it

Add the following snippet to your own Metacello baseline or configuration:

```smalltalk
spec
  baseline: 'ContainersPersistentQueue'
  with: [ spec repository: 'github://pharo-containers/Containers-PersistentQueue/src' ].
```

---

## Basic Usage

Because the queue is immutable, every operation returns the **next state**. You must capture the returned value.

```smalltalk
"1. Initialize an empty queue"
q0 := CTPersistentQueue empty.

"2. Enqueue returns a brand new queue version"
q1 := q0 enqueue: 'Codeforces'.
q2 := q1 enqueue: 'AtCoder'.

"3. Pop returns only the next queue state, optimized to prevent Association allocations"
q3 := q2 pop. 

"4. Peek safely views the front element without altering the queue"
q2 peek. " => 'Codeforces' "

"5. Dequeue returns an Association ( poppedValue -> nextQueueState )"
result := q2 dequeue.
poppedValue := result key.     " => 'Codeforces' "
nextQueue := result value.     " => Queue containing only 'AtCoder' "
```

---

## Time & Space Complexity

| Operation | Time Complexity | Space Complexity (Allocations) |
| :--- | :--- | :--- |
| `empty` | $O(1)$ | $O(1)$ |
| `enqueue:` | $O(1)$ amortized | $O(1)$ |
| `dequeue` | $O(1)$ amortized | $O(1)$ |
| `pop` | $O(1)$ amortized | $O(1)$ |
| `peek` | $O(1)$ | $O(1)$ |

---

## Performance & Empirical Proof

Benchmarks were performed using the `Containers-PersistentQueue-Benchmarks` suite to measure pure algorithmic execution time and Garbage Collection (GC) overhead. 

| Workload | Operations | Execution Time (µs) | GC Penalty |
| :--- | :--- | :--- | :--- |
| **Burst Enqueue** | 100,000 enqueues | 2,158 µs | 0.00% |
| **Burst Dequeue** | 100,000 dequeues | 32,467 µs | 33.83% |
| **Time Travel Save** | 10,000 saves | 288 µs | 0.00% |
| **Random History Read** | 1,000 random reads | 622,105 µs | 8.20% |
| **Server Snapshot Simulation** | 250,000 ops (5 branches) | 43,357 µs | 29.98% |

**Note on Amortized Reversals & Garbage Collection:** The Two-Stack architecture occasionally requires an $O(N)$ reversal of the rear stack when the front stack is empty. This triggers a localized memory allocation spike, which is reflected in the ~35% GC penalty during the Burst Dequeue workload. However, because this cost is mathematically amortized over all operations, the queue maintains an overall $O(1)$ performance profile without suffering the catastrophic memory wall of $O(N)$ deep-copying.

---

## Contributing

This library is part of the [Pharo Containers](https://github.com/pharo-containers) project. Contributions are welcome, whether implementing additional functional combinators, improving test coverage, or enhancing documentation. Please open an issue or pull request on GitHub.