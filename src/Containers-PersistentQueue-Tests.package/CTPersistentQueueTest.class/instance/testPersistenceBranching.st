tests
testPersistenceBranching
    | base branchA branchB |
    base := emptyQueue enqueue: 'Root'.
    
    "Thread 1 pushes A, Thread 2 pushes B from the exact same point in time"
    branchA := base enqueue: 'A'.
    branchB := base enqueue: 'B'.
    
    self assert: branchA asArray equals: #('Root' 'A').
    self assert: branchB asArray equals: #('Root' 'B').
    self assert: base asArray equals: #('Root').