tests
testBoundaryConditionsAndPeek
    | q1 |
    "1. Dequeuing an empty queue should fail safely"
    self should: [ emptyQueue dequeue ] raise: Error description: 'Empty queue must raise an Error on dequeue'.
    
    "2. Peek should return the value without altering the queue"
    q1 := emptyQueue enqueue: 'Target'.
    self assert: q1 peek equals: 'Target'.
    
    "3. Ensure peek didn't drain the queue"
    self deny: q1 isEmpty.
    self assert: q1 dequeue key equals: 'Target'.