let num = 9

// Parens are optional.
if (num < 0) {
    println("num is negative")
} else if num < 10 {
    println("num is single-digit") // num is single-digit
} else {
    println("num is multi-digit")
}

// There are no 'truthy' conditionals.
// The condition must be a boolean expression...

if 7 % 2 == 2 {
    println("7 is even")     // IDE helpfully notes, "Will never be executed"
} else {
    println("7 is odd")      // 7 is odd
}


// ...But optionals allow for shorthand
// non-nil + assignment conditionals

var optionalString:String? = "Hello?"

if let a = optionalString {
    println(a)               // Hello?
}

optionalString = nil

if let b = optionalString {
    println("yep")
} else {
    println("nope")         // nope
}
