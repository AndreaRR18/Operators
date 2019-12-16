func incr(_ x: Int) -> Int {
    return x + 1
}

func incrSideEffect(_ x: inout Int) -> Void {
    x += 1
}

func square(_ x: Int) -> Int {
    return x * x
}

func squareSideEffect(_ x: inout Int) -> Void {
    x = x * x
}

func toString(_ x: Int) -> String {
    return "\(x)"
}

func addGenericLog<A>(_ value: A) -> (A,[String]) {
    return (value, ["TEST"])
}

func toOptional<A>(_ value: A) -> Optional<A> {
    return Optional.some(value)
}


func toNil<A>(_ value: A) -> Optional<A> {
    return nil
}
