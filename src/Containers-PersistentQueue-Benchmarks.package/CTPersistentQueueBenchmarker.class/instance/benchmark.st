as yet unclassified
benchmark
    | startFullGC startIncGC startTime endFullGC endIncGC endTime |
    
    startFullGC := Smalltalk vm totalFullGCTime.
    startIncGC := Smalltalk vm totalIncrementalGCTime.
    startTime := Time primUTCMicrosecondsClock.

    block value.
    
    endTime := Time primUTCMicrosecondsClock - startTime.
    endFullGC := (Smalltalk vm totalFullGCTime - startFullGC) * 1000.
    endIncGC := (Smalltalk vm totalIncrementalGCTime - startIncGC) * 1000.

    ^ CTPersistentQueueBenchmarkerResult new
          executionTime: endTime;
          fullGCTime: endFullGC;
          incrementalGCTime: endIncGC;
          yourself