import Foundation

// As an alternative to multiple return values (Go)
// Or Exceptions (every other language)
// Optionals are used to handle failure cases when
// you're good and ready. Sorta like a lightweight
// Maybe monad, without the FP hoity-toity.

var one = "1"
var intVal = Int(one)

// Use a if-check to determine if there's an underlying value.
if let intVal = Int(one) {
    // And then access the underlying value with !
    print(intVal)                                              // 1
}

var nope = "please"
var nopeIntVal = Int(nope)

if nopeIntVal == nil {
    print("Couldn't convert the string to an int")
}

// Creating optionals.
var maybe:String? = nil

print(maybe)                                                  // nil
print(maybe == nil)                                           // true

maybe = "yep"

print(maybe)                                                  // yep
