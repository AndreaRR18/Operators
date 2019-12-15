precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A,B>(
    a: A,
    f: (A) -> B
) -> B {
     f(a)
}

public func |> <A>(
    a: inout A,
    f: (inout A) -> Void
) -> Void {
    f(&a)
}
