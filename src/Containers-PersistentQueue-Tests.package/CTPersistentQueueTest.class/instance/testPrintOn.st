tests
testPrintOn
    | q string |
    q := emptyQueue enqueue: 1.
    q := q enqueue: 2.
    
    string := String streamContents: [ :str |
        q printOn: str ].
    
    self assert: (string includesSubstring: '1').
    self assert: (string includesSubstring: '2').