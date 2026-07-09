as yet unclassified
runBurstDequeueBenchmark
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