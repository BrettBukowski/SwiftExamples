let num = 9

// Parens are optional.
if (num < 0) {
    print("num is negative")
} else if num < 10 {
    print("num is single-digit") // num is single-digit
} else {
    print("num is multi-digit")
}

// There are no 'truthy' conditionals.
// The condition must be a boolean expression...

if 7 % 2 == 2 {
    print("7 is even")     // IDE helpfully notes, "Will never be executed"
} else {
    print("7 is odd")      // 7 is odd
}


// ...But optionals allow for shorthand
// non-nil + assignment conditionals

var optionalString:String? = "Hello?"

if let a = optionalString {
    print(a)               // Hello?
}

optionalString = nil

if let b = optionalString {
    print("yep")
} else {
    print("nope")         // nope
}
