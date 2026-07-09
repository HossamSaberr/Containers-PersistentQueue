initialization
printOn: aStream
    "Standard Smalltalk printing for better debugger visibility."
    | isFirst |
    super printOn: aStream.
    aStream nextPut: $(.
    
    isFirst := true.
    self do: [ :each | 
        isFirst 
            ifTrue: [ isFirst := false ]
            ifFalse: [ aStream nextPutAll: ', ' ].
        each printOn: aStream ].
        
    aStream nextPut: $)