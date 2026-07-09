running
run
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