precedencegroup ApplyComposition {
    higherThan: ForwardComposition
    associativity: left
}

infix operator ><: ApplyComposition

public func >< <Root, Value>(
    _ kp: WritableKeyPath<Root, Value>,
    _ update: @escaping (Value) -> Value
) -> (Root) -> Root {
    return { root in
        var rootCopy = root
        rootCopy[keyPath: kp] = update(rootCopy[keyPath: kp])
        return rootCopy
    }
}

public func prop<Root, Value>(_ kp: WritableKeyPath<Root, Value>)
    -> (@escaping(Value) -> Value)
    -> (Root) -> Root {
        return { update in
            return { root in
                var rootCopy = root
                rootCopy[keyPath: kp] = update(rootCopy[keyPath: kp])
                return rootCopy
            }
        }
}
