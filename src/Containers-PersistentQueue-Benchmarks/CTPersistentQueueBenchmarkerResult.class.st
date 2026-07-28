Class {
	#name : 'CTPersistentQueueBenchmarkerResult',
	#superclass : 'Object',
	#instVars : [
		'executionTime',
		'fullGCTime',
		'incrementalGCTime'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> executionTime [
    ^ executionTime
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> executionTime: anInteger [
    executionTime := anInteger
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> fullGCTime [
    ^ fullGCTime
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> fullGCTime: anInteger [
    fullGCTime := anInteger
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> incrementalGCTime [
    ^ incrementalGCTime
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> incrementalGCTime: anInteger [
    incrementalGCTime := anInteger
]

{ #category : 'accessing' }
CTPersistentQueueBenchmarkerResult >> relativeGCTime [
    executionTime = 0 ifTrue: [ ^ '0.00 %' ].
    ^ (((fullGCTime + incrementalGCTime) / executionTime * 100) asFloat
           printShowingDecimalPlaces: 2) , ' %'
]
