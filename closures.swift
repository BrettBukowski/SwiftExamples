import Foundation
// Closures have the syntax of:

/*
{ (parameters) -> return type in
body
}
*/

var numbers = [1, 2, 3, 4]

var reversed = numbers.sort({(a: Int, b: Int) -> Bool in
    return a > b;
})

// But type inference allows us to omit the types
// and write something more succinct...
reversed = numbers.sort({ a, b in return a > b })

// ...And single-expression closures can even omit the return keyword.
reversed = numbers.sort({ a, b in a > b })

// ...And even the param names can be omitted.
reversed = numbers.sort({ $0 > $1 })

// ...But why stop there? Greater-than is an operator function!
reversed = numbers.sort(>)

// Closures, of course, have the ability to access the variables
// in scope at the time the function is defined.

func sizeOfNumbers() -> Int {
    return numbers.count
}

print(String(sizeOfNumbers()))              // 4

numbers.append(5)

print(String(sizeOfNumbers()))              // 5

// # Trailing Closures

// Similar to Ruby's blocks, if a function accepts a closure,
// you can specify it after the function's parens.

reversed = numbers.sort { $0 >  $1 }

var toStringed = numbers.map {
    (num: Int) -> String in
    return String(num)
}
