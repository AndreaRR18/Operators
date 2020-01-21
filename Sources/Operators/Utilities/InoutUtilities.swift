func toInout<A>(
    _ f: @escaping (A) -> A
) -> ((inout A) -> Void) {
    
    return { a in
        a = f(a)
    }
}

func fromInout<A>(
    _ f: @escaping (inout A) -> Void
) -> ((A) -> A) {
    
    return { a in
        var copy = a
        f(&copy)
        return copy
    }
}
