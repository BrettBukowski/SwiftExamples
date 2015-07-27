var letters = ("a", "b")

// Decomposing.
let (first, second) = letters

print(first)                      // a
print(second)                     // b

// Underscore to ignore, just like Go.
var (a, _) = letters

print(a)                         // a

// Or access values via index.
print(letters.0)                 // a
print(letters.1)                 // b

// Naming elements.
var letters2 = (first: "a", second: "b")
print(letters2.first)            // a
print(letters2.second)           // b
