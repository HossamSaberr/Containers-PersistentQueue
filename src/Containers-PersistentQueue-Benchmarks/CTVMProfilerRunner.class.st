Class {
	#name : 'CTVMProfilerRunner',
	#superclass : 'Object',
	#instVars : [
		'benchmarkClass',
		'executionTime',
		'allocatedBytes',
		'gcTime'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'accessing' }
CTVMProfilerRunner >> benchmarkClass: aClass [
	benchmarkClass := aClass
]

{ #category : 'export' }
CTVMProfilerRunner >> exportToJson [
	| dict fileRef |
	dict := Dictionary new.
	dict at: 'benchmark' put: benchmarkClass name asString.
	dict at: 'executionTime_us' put: executionTime.
	dict at: 'allocatedBytes' put: allocatedBytes.
	dict at: 'gcTime_ms' put: gcTime.
	
	fileRef := 'rebench-metrics.json' asFileReference.
	
	fileRef writeStreamDo: [ :stream | 
		stream setToEnd.
		STONJSON put: dict onStream: stream.
		stream cr ]
]

{ #category : 'running' }
CTVMProfilerRunner >> run [
	| startBytes startGC startTime endBytes endGC endTime instance |
	
	instance := benchmarkClass new.
	instance setUp.
	
	startBytes := Smalltalk vm parameterAt: 34.
	startGC := Smalltalk vm parameterAt: 7.
	startTime := Time primUTCMicrosecondsClock.
	
	instance run.
	
	endTime := Time primUTCMicrosecondsClock.
	endBytes := Smalltalk vm parameterAt: 34.
	endGC := Smalltalk vm parameterAt: 7.
	
	executionTime := endTime - startTime.
	allocatedBytes := endBytes - startBytes.
	gcTime := endGC - startGC.
	
	self exportToJson
]
