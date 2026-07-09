initialization
size
    "O(N) size calculation for now."
    | count |
    count := 0.
    self do: [ :each | count := count + 1 ].
    ^ count