running
run
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        randomIndices do: [ :idx | (history at: idx) peek ]
    ].
    
    result := benchmarker benchmark.
    ^ result