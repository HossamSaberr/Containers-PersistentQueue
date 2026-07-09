initialization
= anObject
    "Two queues are equal if they have the same elements in the same order."
    self == anObject ifTrue: [ ^ true ].
    self class = anObject class ifFalse: [ ^ false ].
    self size = anObject size ifFalse: [ ^ false ].
    ^ self asArray = anObject asArray