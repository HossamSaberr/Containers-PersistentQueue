tests
testPop
    | q1 q2 q3 |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    "Pop should return the new queue state directly, not an Association"
    q3 := q2 pop.
    
    self assert: q3 class equals: CTPersistentQueue.
    self assert: q3 size equals: 1.
    self assert: q3 peek equals: 'B'.
    
    "Ensure we safely error if trying to pop an empty queue"
    self should: [ emptyQueue pop ] raise: Error description: 'Cannot pop from an empty queue'.