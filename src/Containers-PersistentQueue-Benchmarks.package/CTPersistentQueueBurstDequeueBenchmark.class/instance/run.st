running
run
    | benchmarker result |
    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        1 to: size do: [ :i | currentQueue := currentQueue dequeue value ]
    ].
    
    result := benchmarker benchmark.
    ^ result