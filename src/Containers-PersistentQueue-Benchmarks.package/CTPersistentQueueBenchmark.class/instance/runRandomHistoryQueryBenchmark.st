as yet unclassified
runRandomHistoryQueryBenchmark
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