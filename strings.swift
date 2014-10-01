// Swift's way of representing strings as encoding-independent
// Unicode characters means that programmers don't have to worry
// as much about encoding issues (like Ruby, Python, etc.), but
// common operations can be a bit tedious as a result, since you
// can't directly index into a string without using a Range
// abstraction.

import UIKit

// # Concatenation

var str = "Hello"
var smile = "😄"
var combined = str + " " + smile

// # Common Operations

var length = countElements(combined) // 7
println(combined.lowercaseString)
println(combined.uppercaseString)

// # Working with Characters

for char in combined {
    println(char)
}

// # Substrings

var trail = combined.substringWithRange(Range<String.Index>(start: str.endIndex, end: combined.endIndex))  // " 😄"

// # Contains

if let range = str.rangeOfString("ello") {
    println("ello")                           // ello
} else {
    println("nope")
}

// Swift has many string methods, most inherited
// from the rich NSString API. But (spoiler alert)
// you can add your own too.

extension String {
    func beginsWith (str: String) -> Bool {
        if let range = self.rangeOfString(str) {
            return range.startIndex == self.startIndex
        }
        return false
    }

    func endsWith (str: String) -> Bool {
        if let range = self.rangeOfString(str) {
            return range.endIndex == self.endIndex
        }
        return false
    }
}

println("find".beginsWith("f"))       // true
println("find".beginsWith("fi"))      // true
println("find".beginsWith("fin"))     // true
println("find".beginsWith("find"))    // true
println("find".beginsWith("finder"))  // false

println("find".endsWith("d"))         // true
println("find".endsWith("nd"))        // true
println("find".endsWith("ind"))       // true
println("find".endsWith("find"))      // true
println("find".endsWith(""))          // false

// # Mutating

combined.splice("🐈", atIndex: combined.rangeOfString(smile)!.startIndex)
combined.removeAtIndex(combined.rangeOfString(smile)!.startIndex)
