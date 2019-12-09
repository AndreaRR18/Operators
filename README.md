# Operators

This library contains all the operator encountered in https://www.pointfree.co/ course.

Indices:

`|>` Pipeforward: get a value and a function and return a new value transformed

`>>>`  ForwardCompose: get two functions and return a single composed function, apply first the left function and then the right function

`<<<` BackwardsCompose: get two functions and return a single composed function, apply first the right function and then the left function

`>=>` FishOperator: get two function with different input/output and compose them

`<>` DiamondOperator: Get two functions with same input/output and compose them

`><` Apply operator: Get a Root model and a function that update its value and return a function from Root to Root

`^` Getter: Functional getter that get a Value from a Root
