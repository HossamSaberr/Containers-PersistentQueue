accessing
relativeGCTime
    executionTime = 0 ifTrue: [ ^ '0.00 %' ].
    ^ (((fullGCTime + incrementalGCTime) / executionTime * 100) asFloat
           printShowingDecimalPlaces: 2) , ' %'