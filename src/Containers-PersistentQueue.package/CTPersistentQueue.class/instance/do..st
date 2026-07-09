initialization
do: aBlock
    "Evaluates aBlock for each element in the queue, perfectly preserving the historical state."
    | current currentState |
    current := self.
    [ current isEmpty ] whileFalse: [ 
        currentState := current dequeue.
        aBlock value: currentState key.
        current := currentState value ]