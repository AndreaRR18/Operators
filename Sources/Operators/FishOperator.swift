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

public func chain<A, B, C, D>(
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

public func chain<A, B, C, D>(
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

//MARK: Result
public func >=> <A,B,C>(
    _ f: @escaping (A) -> Result<B, Error>,
    _ g: @escaping (B) -> Result<C, Error>
) -> (A) -> (Result<C, Error>) {
    return { a in
        switch f(a) {
        case .success(let b):
            return g(b)
        case .failure(let error):
            return .failure(error)
        }
    }
}

public func chain <A,B,C>(
    _ f: @escaping (A) -> Result<B, Error>,
    _ g: @escaping (B) -> Result<C, Error>
) -> (A) -> (Result<C, Error>) {
    return { a in
       switch f(a) {
        case .success(let b):
            return g(b)
        case .failure(let error):
            return .failure(error)
        }
    }
}

public func chain<A, B, C, D>(
  _ f: @escaping (A) -> (Result<B, Error>),
  _ g: @escaping (B) -> (Result<C, Error>),
  _ h: @escaping (C) -> (Result<D, Error>)
  ) -> ((A) -> (Result<D, Error>)) {

  return chain(f, chain(g, h))
}
