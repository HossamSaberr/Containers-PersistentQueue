running
setUp
    | randomizer |
    super setUp.
    size := 10000.
    history := Array new: size.
    randomizer := Random new seed: 42.
    
    "Pre-generate all historical timelines"
    1 to: size do: [ :i |
        queue := queue enqueue: i.
        history at: i put: queue.
    ].

    "Pre-generate the random queries so RNG execution time isn't benchmarked"
    randomIndices := (1 to: 1000) collect: [ :each | randomizer nextInteger: size ].