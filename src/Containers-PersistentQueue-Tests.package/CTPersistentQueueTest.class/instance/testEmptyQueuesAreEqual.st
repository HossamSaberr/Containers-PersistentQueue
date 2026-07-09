tests
testEmptyQueuesAreEqual
    | anotherEmpty |
    anotherEmpty := CTPersistentQueue empty.
    
    self assert: emptyQueue equals: anotherEmpty.
    self assert: emptyQueue hash equals: anotherEmpty hash.
    self assert: emptyQueue asArray isEmpty.