precedencegroup BackwardsComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <<<: BackwardsComposition

func <<< <A,B,C>(_ g: @escaping (B) -> C, _ f: @escaping (A) -> B) -> (A) -> C {
    return { a in
        g(f(a))
    }
}
