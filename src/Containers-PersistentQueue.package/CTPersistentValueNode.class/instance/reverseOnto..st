initialization
reverseOnto: anAccumulatorNode
    "Recursive case: push my value onto the accumulator, and tell the next node to continue"
    ^ next reverseOnto: (anAccumulatorNode push: value)