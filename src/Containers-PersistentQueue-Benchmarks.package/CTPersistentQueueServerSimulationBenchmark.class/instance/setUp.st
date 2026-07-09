running
setUp
    super setUp.
    size := 100000.
    "Simulate an incoming stream of network events"
    1 to: size do: [ :i | queue := queue enqueue: i ].