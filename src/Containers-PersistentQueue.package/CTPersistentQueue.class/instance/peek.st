initialization
peek
    ^ frontStack 
        ifEmpty: [ 
            | reversedRear |
            reversedRear := rearStack reversed.
            reversedRear 
                ifEmpty: [ self error: 'Cannot peek into an empty queue' ]
                ifNotEmpty: [ :newFront |
                    newFront value ] ]
        ifNotEmpty: [ :front |
            front value ]