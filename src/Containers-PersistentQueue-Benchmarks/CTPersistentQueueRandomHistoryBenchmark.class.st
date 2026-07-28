Class {
	#name : 'CTPersistentQueueRandomHistoryBenchmark',
	#superclass : 'CTPersistentQueueAbstractBenchmark',
	#instVars : [
		'history',
		'randomIndices'
	],
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueRandomHistoryBenchmark >> run [
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        randomIndices do: [ :idx | (history at: idx) peek ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'running' }
CTPersistentQueueRandomHistoryBenchmark >> setUp [
    | randomizer |
    super setUp.
    size := 10000.
    history := Array new: size.
    randomizer := Random new seed: 42.
    
    "Pre-generate all historical timelines"
    1 to: size do: [ :i |
        queue := queue enqueue: i.
        history at: i put: queue.
    ].

    "Pre-generate the random queries so RNG execution time isn't benchmarked"
    randomIndices := (1 to: 1000) collect: [ :each | randomizer nextInteger: size ].
]
