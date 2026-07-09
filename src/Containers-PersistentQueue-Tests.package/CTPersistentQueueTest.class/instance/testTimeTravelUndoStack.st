tests
testTimeTravelUndoStack
    | history current |
    history := OrderedCollection new.
    current := emptyQueue.
    
    "Generate 10 historical states"
    1 to: 10 do: [ :i |
        current := current enqueue: i.
        history add: current ].
        
    "Verify the extremes"
    self assert: (history at: 5) size equals: 5.
    self assert: (history at: 5) peek equals: 1.
    self assert: history last size equals: 10.
    
    "Time travel back to state 5 and branch off into a new reality"
    current := history at: 5.
    current := current enqueue: 99.
    
    self assert: current size equals: 6.
    self assert: current asArray equals: #(1 2 3 4 5 99).
    
    "Verify the original future (state 10) was not destroyed by altering the past"
    self assert: history last asArray equals: #(1 2 3 4 5 6 7 8 9 10).