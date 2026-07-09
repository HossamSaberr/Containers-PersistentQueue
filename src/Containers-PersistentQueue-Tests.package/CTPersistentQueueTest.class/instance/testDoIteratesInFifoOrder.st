tests
testDoIteratesInFifoOrder
    | q elements |
    q := emptyQueue enqueue: 'First'.
    q := q enqueue: 'Second'.
    q := q enqueue: 'Third'.

    elements := OrderedCollection new.
    q do: [ :each | elements add: each ].

    self assert: elements asArray equals: #('First' 'Second' 'Third').