var letters = ("a", "b")

// Decomposing.
let (first, second) = letters

println(first)                      // a
println(second)                     // b

// Underscore to ignore, just like Go.
var (a, _) = letters

println(a)                         // a

// Or access values via index.
println(letters.0)                 // a
println(letters.1)                 // b

// Naming elements.
var letters2 = (first: "a", second: "b")
println(letters2.first)            // a
println(letters2.second)           // b
