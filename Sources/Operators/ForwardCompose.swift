precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication, EffectfulComposition
}

infix operator >>>: ForwardComposition

public func >>> <A,B,C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        g(f(a))
    }
}

func pipe<A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
   { g(f($0)) }
}

func pipe<A, B, C, D>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C,
    _ h: @escaping (C) -> D
) -> (A) -> D {
   { h(g(f($0))) }
}
