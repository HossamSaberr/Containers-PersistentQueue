as yet unclassified
runBurstEnqueueBenchmark
    | benchmarker result q size |
    size := 100000.
    q := CTPersistentQueue empty.
    
    benchmarker := CTPersistentQueueBenchmarker new.
    benchmarker blockToExecute: [
        1 to: size do: [ :i | q := q enqueue: i ]
    ].
    
    result := benchmarker benchmark.
    ^ result