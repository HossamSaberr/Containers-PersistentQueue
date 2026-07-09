tests
testInterleavedOperations
    | q1 q2 q3 q4 q5 result |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    "Pop 'A'. The queue (q3) now functionally contains only 'B'."
    result := q2 dequeue.
    self assert: result key equals: 'A'.
    q3 := result value.
    
    "Push 'C' onto the queue. FrontStack has 'B', RearStack has 'C'."
    q4 := q3 enqueue: 'C'.
    self assert: q4 peek equals: 'B'.
    
    "Pop 'B'. This should force a structural merge."
    result := q4 dequeue.
    self assert: result key equals: 'B'.
    q5 := result value.
    
    self assert: q5 asArray equals: #('C').