precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A,B>(a: A, f: (A) -> B) -> B {
    return f(a)
}
