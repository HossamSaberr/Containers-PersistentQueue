tests
testEnqueuePreservesImmutability
    | q2 |
    q2 := emptyQueue enqueue: 'A'.
    
    self assert: emptyQueue isEmpty description: 'The original queue must remain completely empty'.
    self deny: q2 isEmpty description: 'The new queue state should contain the enqueued element'.