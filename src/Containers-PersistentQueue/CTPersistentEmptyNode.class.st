Class {
	#name : 'CTPersistentEmptyNode',
	#superclass : 'CTPersistentStackNode',
	#category : 'Containers-PersistentQueue',
	#package : 'Containers-PersistentQueue'
}

{ #category : 'controlling' }
CTPersistentEmptyNode >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
    ^ emptyBlock value
]

{ #category : 'testing' }
CTPersistentEmptyNode >> isEmpty [
    ^ true
]

{ #category : 'private' }
CTPersistentEmptyNode >> reverseOnto: anAccumulatorNode [
    "Base case: end of the list. Return the accumulated reversed list."
    ^ anAccumulatorNode
]
