Class {
	#name : 'CTPersistentQueueBenchmarker',
	#superclass : 'Object',
	#instVars : [
		'block'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmarker >> benchmark [
    | startFullGC startIncGC startTime endFullGC endIncGC endTime |
    
    startFullGC := Smalltalk vm totalFullGCTime.
    startIncGC := Smalltalk vm totalIncrementalGCTime.
    startTime := Time primUTCMicrosecondsClock.

    block value.
    
    endTime := Time primUTCMicrosecondsClock - startTime.
    endFullGC := (Smalltalk vm totalFullGCTime - startFullGC) * 1000.
    endIncGC := (Smalltalk vm totalIncrementalGCTime - startIncGC) * 1000.

    ^ CTPersistentQueueBenchmarkerResult new
          executionTime: endTime;
          fullGCTime: endFullGC;
          incrementalGCTime: endIncGC;
          yourself
]

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmarker >> blockToExecute: aBlock [
    block := aBlock
]
