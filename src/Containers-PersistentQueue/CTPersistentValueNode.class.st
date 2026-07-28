Class {
	#name : 'CTPersistentValueNode',
	#superclass : 'CTPersistentStackNode',
	#instVars : [
		'value',
		'next'
	],
	#category : 'Containers-PersistentQueue',
	#package : 'Containers-PersistentQueue'
}

{ #category : 'as yet unclassified' }
CTPersistentValueNode class >> value: anObject next: aNode [
    ^ self new initializeValue: anObject next: aNode
]

{ #category : 'initialization' }
CTPersistentValueNode >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
    ^ notEmptyBlock value: self
]

{ #category : 'initialization' }
CTPersistentValueNode >> initializeValue: anObject next: aNode [
    value := anObject.
    next := aNode.
    ^ self
]

{ #category : 'initialization' }
CTPersistentValueNode >> isEmpty [
    ^ false
]

{ #category : 'initialization' }
CTPersistentValueNode >> next [
    ^ next
]

{ #category : 'initialization' }
CTPersistentValueNode >> reverseOnto: anAccumulatorNode [
    "Recursive case: push my value onto the accumulator, and tell the next node to continue"
    ^ next reverseOnto: (anAccumulatorNode push: value)
]

{ #category : 'initialization' }
CTPersistentValueNode >> value [
    ^ value
]
