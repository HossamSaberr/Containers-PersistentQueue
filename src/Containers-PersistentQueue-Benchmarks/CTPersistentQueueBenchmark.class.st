Class {
	#name : 'CTPersistentQueueBenchmark',
	#superclass : 'Object',
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmark >> runBurstDequeueBenchmark [
    | benchmarker result q size current |
    size := 100000.
    q := CTPersistentQueue empty.
    1 to: size do: [ :i | q := q enqueue: i ].
    
    current := q.
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i | current := current dequeue value ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmark >> runBurstEnqueueBenchmark [
    | benchmarker result q size |
    size := 100000.
    q := CTPersistentQueue empty.
    
    benchmarker := CTPersistentQueueBenchmarker new.
    benchmarker blockToExecute: [
        1 to: size do: [ :i | q := q enqueue: i ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmark >> runRandomHistoryQueryBenchmark [
    "Forces lazy-evaluation of the amortized reverse operations across random historical states"
    | benchmarker result q size history randomIndices randomizer |
    size := 10000.
    q := CTPersistentQueue empty.
    history := Array new: size.
    randomizer := Random new seed: 42.
    
    1 to: size do: [ :i |
        q := q enqueue: i.
        history at: i put: q.
    ].

    randomIndices := (1 to: 1000) collect: [ :each | randomizer nextInteger: size ].
    
    benchmarker := CTPersistentQueueBenchmarker new.
    benchmarker blockToExecute: [
        randomIndices do: [ :idx | (history at: idx) peek ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'as yet unclassified' }
CTPersistentQueueBenchmark >> runTimeTravelSaveBenchmark [
    "Simulates saving every single historical state during 10,000 enqueues"
    | benchmarker result q size history |
    size := 10000.
    q := CTPersistentQueue empty.
    history := Array new: size.
    
    benchmarker := CTPersistentQueueBenchmarker new.
    benchmarker blockToExecute: [
        1 to: size do: [ :i |
            q := q enqueue: i.
            history at: i put: q
        ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]
