Class {
	#name : 'CTPersistentQueueBurstEnqueueBenchmark',
	#superclass : 'CTPersistentQueueAbstractBenchmark',
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueBurstEnqueueBenchmark >> run [
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i | queue := queue enqueue: i ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]
