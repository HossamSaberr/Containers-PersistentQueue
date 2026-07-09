initialization
asArray
    "Extracts the queue's elements into a native Pharo array."
    | extracted |
    extracted := OrderedCollection new.
    self do: [ :each | extracted add: each ].
    ^ extracted asArray