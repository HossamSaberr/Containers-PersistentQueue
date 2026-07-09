running
setUp
    super setUp.
    size := 10000. "Scale down slightly to avoid massive array allocation overhead"
    history := Array new: size.