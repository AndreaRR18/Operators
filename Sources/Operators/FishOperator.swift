precedencegroup EffectfulComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

//MARK: Log
public func >=> <A,B,C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
) -> (A) -> (C, [String]) {
    return { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        
        return (c, (logs + moreLogs))
    }
}

public func chain <A,B,C>(
    _ f: @escaping (A) -> (B, [String]),
    _ g: @escaping (B) -> (C, [String])
) -> (A) -> (C, [String]) {
    return { a in
        let (b, logs) = f(a)
        let (c, moreLogs) = g(b)
        
        return (c, (logs + moreLogs))
    }
}

func chain<A, B, C, D>(
  _ f: @escaping (A) -> (B, [String]),
  _ g: @escaping (B) -> (C, [String]),
  _ h: @escaping (C) -> (D, [String])
  ) -> ((A) -> (D, [String])) {

  return chain(f, chain(g, h))
}

//MARK: Optional
public func >=> <A,B,C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C?
) -> (A) -> (C?) {
    return { a in
        guard let b = f(a) else { return nil }
        return g(b)
    }
}

public func chain <A,B,C>(
    _ f: @escaping (A) -> B?,
    _ g: @escaping (B) -> C?
) -> (A) -> (C?) {
    return { a in
        guard let b = f(a) else { return nil }
        return g(b)
    }
}

func chain<A, B, C, D>(
  _ f: @escaping (A) -> (B?),
  _ g: @escaping (B) -> (C?),
  _ h: @escaping (C) -> (D?)
  ) -> ((A) -> (D?)) {

  return chain(f, chain(g, h))
}

//MARK: Array
public func >=> <A,B,C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> [C]
) -> (A) -> ([C]) {
    return { a in
        return f(a).flatMap(g)
    }
}

public func chain <A,B,C>(
    _ f: @escaping (A) -> [B],
    _ g: @escaping (B) -> [C]
) -> (A) -> ([C]) {
    return { a in
        return f(a).flatMap(g)
    }
}
