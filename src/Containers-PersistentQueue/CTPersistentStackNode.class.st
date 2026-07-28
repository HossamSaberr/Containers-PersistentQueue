Class {
	#name : 'CTPersistentStackNode',
	#superclass : 'Object',
	#category : 'Containers-PersistentQueue',
	#package : 'Containers-PersistentQueue'
}

{ #category : 'adding' }
CTPersistentStackNode >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
    ^ self subclassResponsibility
]

{ #category : 'adding' }
CTPersistentStackNode >> isEmpty [
    ^ self subclassResponsibility
]

{ #category : 'adding' }
CTPersistentStackNode >> push: anObject [
    ^ CTPersistentValueNode value: anObject next: self
]

{ #category : 'adding' }
CTPersistentStackNode >> reverseOnto: anAccumulatorNode [
    ^ self subclassResponsibility
]

{ #category : 'adding' }
CTPersistentStackNode >> reversed [
    "Initiate the functional reversal with an empty accumulator"
    ^ self reverseOnto: CTPersistentEmptyNode new
]
