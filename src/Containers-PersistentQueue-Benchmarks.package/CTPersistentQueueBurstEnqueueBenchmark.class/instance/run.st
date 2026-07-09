running
run
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i | queue := queue enqueue: i ]
    ].
    
    result := benchmarker benchmark.
    ^ result