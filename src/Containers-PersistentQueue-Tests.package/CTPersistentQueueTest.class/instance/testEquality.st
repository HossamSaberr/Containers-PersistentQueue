tests
testEquality
    | q1 q2 q3 |
    q1 := emptyQueue enqueue: 'A'.
    q1 := q1 enqueue: 'B'.
    
    q2 := emptyQueue enqueue: 'A'.
    q2 := q2 enqueue: 'B'.
    
    q3 := emptyQueue enqueue: 'A'.
    q3 := q3 enqueue: 'C'.
    
    self assert: q1 equals: q2.
    self deny: q1 = q3.