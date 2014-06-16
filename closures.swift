// Closures have the syntax of:

/*
{ (parameters) -> return type in
body
}
*/

var letters = ["a", "b", "c", "d"]

var reversed = sort(letters, {(a: String, b: String) -> Bool in
    return a > b;
    })

// But type inference allows us to omit the types
// and write something more succinct...
reversed = sort(letters, { a, b in return a > b })

// ...And single-expression closures can even omit the return keyword.
reversed = sort(letters, { a, b in a > b })

// ...And even the param names can be omitted.
reversed = sort(letters, { $0 > $1 })

// ...But why stop there? Greater-than is an operator function!
reversed = sort(letters, >)

// Closures, of course, have the ability to access the variables
// in scope at the time the function is defined.

func sizeOfLetters() -> Int {
    return letters.count
}

println(String(sizeOfLetters()))              // 4

letters.append("e")

println(String(sizeOfLetters()))              // 5

// # Trailing Closures

// Similar to Ruby's blocks, if a function accepts a closure,
// you can specify it after the function's parens.

reversed = sort(letters) { $0 >  $1 }

var uppercased = letters.map {
    (string: String) -> String in
    return string.uppercaseString
}
