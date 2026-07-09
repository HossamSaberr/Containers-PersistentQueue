as yet unclassified
runTimeTravelSaveBenchmark
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