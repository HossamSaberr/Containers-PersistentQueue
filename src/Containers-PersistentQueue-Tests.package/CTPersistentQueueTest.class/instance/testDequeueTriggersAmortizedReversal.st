tests
testDequeueTriggersAmortizedReversal
    | q1 q2 q3 result1 result2 newQueue |
    
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    q3 := q2 enqueue: 'C'.
    
    "Right now, frontStack is empty, rearStack has (C -> B -> A)"
    result1 := q3 dequeue.
    self assert: result1 key equals: 'A'.
    
    newQueue := result1 value.
    result2 := newQueue dequeue.
    self assert: result2 key equals: 'B'.
    
    "CRITICAL: The original q3 must remain completely intact despite the reversal!"
    self assert: q3 dequeue key equals: 'A'.