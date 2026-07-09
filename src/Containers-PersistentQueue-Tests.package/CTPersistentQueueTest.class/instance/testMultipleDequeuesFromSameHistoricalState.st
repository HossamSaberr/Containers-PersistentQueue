tests
testMultipleDequeuesFromSameHistoricalState
    | base result1 result2 |
    base := emptyQueue enqueue: 'A'.
    base := base enqueue: 'B'.
    base := base enqueue: 'C'.
    
    "Branch 1 pops A"
    result1 := base dequeue.
    
    "Branch 2 also pops A from the exact same historical base"
    result2 := base dequeue.
    
    self assert: result1 key equals: 'A'.
    self assert: result2 key equals: 'A'.
    
    self assert: result1 value asArray equals: #('B' 'C').
    self assert: result2 value asArray equals: #('B' 'C').
    
    "They should be structurally identical, but technically different queue instances"
    self deny: result1 value identicalTo: result2 value.