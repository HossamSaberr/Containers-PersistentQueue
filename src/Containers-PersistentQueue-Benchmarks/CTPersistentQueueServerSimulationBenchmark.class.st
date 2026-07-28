Class {
	#name : 'CTPersistentQueueServerSimulationBenchmark',
	#superclass : 'CTPersistentQueueAbstractBenchmark',
	#category : 'Containers-PersistentQueue-Benchmarks',
	#package : 'Containers-PersistentQueue-Benchmarks'
}

{ #category : 'running' }
CTPersistentQueueServerSimulationBenchmark >> run [
    | benchmarker result mainServer snapshot workers |
    mainServer := queue.
    workers := Array new: 5.

    benchmarker := CTPersistentQueueBenchmarker new.
    
    benchmarker blockToExecute: [
        "Main server processes the first 50,000 events normally"
        1 to: (size / 2) do: [ :i | 
            mainServer := mainServer pop ].
        
        "MID DAY SNAPSHOT (O(1) memory, 0 deep copies)"
        snapshot := mainServer.
        
        "Spawn 5 parallel simulations branching from that exact moment"
        1 to: 5 do: [ :w | workers at: w put: snapshot ].
        
        "Each of the 5 simulations independently drains the remaining 50,000 tasks"
        1 to: 5 do: [ :w |
            | simQueue |
            simQueue := workers at: w.
            1 to: (size / 2) do: [ :i | 
                simQueue := simQueue pop ] ]
    ].
    
    result := benchmarker benchmark.
    ^ result
]

{ #category : 'running' }
CTPersistentQueueServerSimulationBenchmark >> setUp [
    super setUp.
    size := 100000.
    "Simulate an incoming stream of network events"
    1 to: size do: [ :i | queue := queue enqueue: i ].
]
