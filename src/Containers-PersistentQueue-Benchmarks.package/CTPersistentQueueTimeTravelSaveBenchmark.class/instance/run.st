running
run
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