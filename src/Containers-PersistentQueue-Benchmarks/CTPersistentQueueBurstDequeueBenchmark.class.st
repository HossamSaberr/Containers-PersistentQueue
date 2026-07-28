Class {
	#name : 'CTPersistentQueueBurstDequeueBenchmark',
	#superclass : 'CTPersistentQueueAbstractBenchmark',
	#instVars : [
		'currentQueue'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueBurstDequeueBenchmark >> run [
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i | currentQueue := currentQueue dequeue value ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'running' }
CTPersistentQueueBurstDequeueBenchmark >> setUp [
    super setUp.
    "Pre-fill the queue so we only benchmark the dequeue phase"
    1 to: size do: [ :i | queue := queue enqueue: i ].
    currentQueue := queue.
]
