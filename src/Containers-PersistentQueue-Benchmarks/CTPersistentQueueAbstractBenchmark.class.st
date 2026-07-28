Class {
	#name : 'CTPersistentQueueAbstractBenchmark',
	#superclass : 'Object',
	#instVars : [
		'queue',
		'size'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueAbstractBenchmark >> run [
    self subclassResponsibility
]

{ #category : 'running' }
CTPersistentQueueAbstractBenchmark >> setUp [
    size := 100000.
    queue := CTPersistentQueue empty.
]
