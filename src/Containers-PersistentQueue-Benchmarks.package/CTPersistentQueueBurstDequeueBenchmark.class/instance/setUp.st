running
setUp
    super setUp.
    "Pre-fill the queue so we only benchmark the dequeue phase"
    1 to: size do: [ :i | queue := queue enqueue: i ].
    currentQueue := queue.