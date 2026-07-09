initialization
enqueue: anObject
    ^ self class 
        front: frontStack 
        rear: (rearStack push: anObject)