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

{ #category : 'controlling' }
CTPersistentValueNode >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
    ^ notEmptyBlock value: self
]

{ #category : 'initialization' }
CTPersistentValueNode >> initializeValue: anObject next: aNode [
    value := anObject.
    next := aNode.
    ^ self
]

{ #category : 'testing' }
CTPersistentValueNode >> isEmpty [
    ^ false
]

{ #category : 'accessing' }
CTPersistentValueNode >> next [
    ^ next
]

{ #category : 'private' }
CTPersistentValueNode >> reverseOnto: anAccumulatorNode [
    "Iterative case: traverse down the node chain via a while loop, pushing values onto the accumulator without growing the call stack"
    | current acc |
    acc := anAccumulatorNode.
    current := self.
    [ current isEmpty ] whileFalse: [
        acc := acc push: current value.
        current := current next ].
    ^ acc
]

{ #category : 'evaluating' }
CTPersistentValueNode >> value [
    ^ value
]
