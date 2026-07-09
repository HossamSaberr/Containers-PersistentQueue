initialization
hash
    "Polymorphic hash based on content to match equality."
    ^ self class hash bitXor: self asArray hash