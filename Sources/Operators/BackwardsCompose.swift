precedencegroup BackwardsComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <<<: BackwardsComposition

public func <<< <A,B,C>(_ g: @escaping (B) -> C, _ f: @escaping (A) -> B) -> (A) -> C {
    return { a in
        g(f(a))
    }
}

public func reversePipe<A, B, C>(
    _ f: @escaping (B) -> C,
    _ g: @escaping (A) -> B
) -> (A) -> C {
   { f(g($0)) }
}

public func reversePipe<A, B, C, D>(
    _ f: @escaping (C) -> D,
    _ g: @escaping (B) -> C,
    _ h: @escaping (A) -> B
) -> (A) -> D {
   { f(g(h($0))) }
}
