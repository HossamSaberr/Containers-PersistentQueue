initialization
dequeue
    ^ frontStack 
        ifEmpty: [ 
            | reversedRear |
            "The front is empty, so we pay the O(N) cost to reverse the rear stack"
            reversedRear := rearStack reversed.
            reversedRear 
                ifEmpty: [ self error: 'Cannot dequeue from an empty queue' ]
                ifNotEmpty: [ :newFront |
                    "Pop the first value, and create the new queue state"
                    newFront value -> (self class 
                        front: newFront next 
                        rear: CTPersistentEmptyNode new) ] ]
        ifNotEmpty: [ :front |
            "The front has elements! O(1) pop and structural sharing of the rear"
            front value -> (self class 
                front: front next 
                rear: rearStack) ]