tests
testStructuralSharingIdentity
    | q1 q2 front1 front2 |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    front1 := q1 instVarNamed: 'frontStack'.
    front2 := q2 instVarNamed: 'frontStack'.
    
    "Because enqueueing only modifies the rear, both versions MUST share the exact same front stack in memory."
    self assert: front1 identicalTo: front2.