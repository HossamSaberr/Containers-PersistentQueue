Class {
	#name : 'CTPersistentQueueTimeTravelSaveBenchmark',
	#superclass : 'CTPersistentQueueAbstractBenchmark',
	#instVars : [
		'history'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueTimeTravelSaveBenchmark >> run [
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i |
            queue := queue enqueue: i.
            history at: i put: queue
        ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'running' }
CTPersistentQueueTimeTravelSaveBenchmark >> setUp [
    super setUp.
    size := 10000. "Scale down slightly to avoid massive array allocation overhead"
    history := Array new: size.
]
