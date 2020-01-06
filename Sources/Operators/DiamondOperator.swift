precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <>: SingleTypeComposition

public func <> <A>(
    f: @escaping (A) -> A,
    g: @escaping (A) -> A
) -> (A) -> A {
    return f >>> g
}

public func <> <A: AnyObject>(
    f: @escaping (inout A) -> Void,
    g: @escaping (inout A) -> Void
) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

public func concat<A: AnyObject>(
  _ f: @escaping (A) -> Void,
  _ g: @escaping (A) -> Void
  )
  -> (A) -> Void {

    return { a in
      f(a)
      g(a)
    }
}

public func concat<A: AnyObject>(
  _ f1: @escaping (A) -> Void,
  _ f2: @escaping (A) -> Void,
  _ fs: ((A) -> Void)...
  )
  -> (A) -> Void {
    
    return { a in
      f1(a)
      f2(a)
      fs.forEach { f in f(a) }
    }
}

public func concat<A>(
  _ fs: ((A) -> A)...
) -> (A) -> A {
    return fs.reduce(identity, >>>)
}

fileprivate func identity<A>(_ a: A) -> A { return a }
