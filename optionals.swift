// As an alternative to multiple return values (Go)
// Or Exceptions (every other language)
// Optionals are used to handle failure cases when
// you're good and ready. Sorta like a lightweight
// Maybe monad, without the FP hoity-toity.

var one = "1"
var intVal = one.toInt()

// Use a if-check to determine if there's an underlying value.
if intVal {
    // And then access the underlying value with !
    println(intVal!)                                             // 1
}

var nope = "please"
var nopeIntVal = nope.toInt()

if !nopeIntVal {
    println("Couldn't convert the string to an int")
}

// Creating optionals.
var maybe:String? = nil

println(maybe)                                                  // nil
println(maybe == nil)                                           // true

maybe = "yep"

println(maybe)                                                  // yep
