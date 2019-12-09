precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

public func compose <A,B,C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
) -> (A) -> (C, [String]) {
    return { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        
        return (c, (logs + moreLogs))
    }
}

public func compose <A,B,C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C?
) -> (A) -> (C?) {
    return { a in
        guard let b = f(a) else { return nil }
        return g(b)
    }
}

public func compose <A,B,C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> [C]
) -> (A) -> ([C]) {
    return { a in
        return f(a).flatMap(g)
    }
}
