initialization
pop
    "Returns only the next queue state"
    ^ frontStack 
        ifEmpty: [ 
            | reversedRear |
            reversedRear := rearStack reversed.
            reversedRear 
                ifEmpty: [ self error: 'Cannot pop from an empty queue' ]
                ifNotEmpty: [ :newFront |
                    self class 
                        front: newFront next 
                        rear: CTPersistentEmptyNode new ] ]
        ifNotEmpty: [ :front |
            self class 
                front: front next 
                rear: rearStack ]