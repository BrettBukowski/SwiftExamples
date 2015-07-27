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

var length = combined.characters.count // 7
print(combined.lowercaseString)
print(combined.uppercaseString)

// # Working with Characters

for char in combined.characters {
    // Loops seven times
    print(char)
}

// # Substrings

var trail = combined.substringWithRange(Range<String.Index>(start: str.endIndex, end: combined.endIndex))  // " 😄"

// # Contains

if let range = str.rangeOfString("ello") {
    print("ello")                           // ello
} else {
    print("nope")
}

//// Swift has many string methods, most inherited
//// from the rich NSString API. But (spoiler alert)
//// you can add your own too.
//
extension String {
    func beginsWith (str: String) -> Bool {
        if let range = self.rangeOfString(str) {
            return range.startIndex == self.startIndex
        }
        return false
    }

    func endsWith (str: String) -> Bool {
        if let range = self.rangeOfString(str, options:NSStringCompareOptions.BackwardsSearch) {
            return range.endIndex == self.endIndex
        }
        return false
    }
}

print("find".beginsWith("f"))       // true
print("find".beginsWith("fi"))      // true
print("find".beginsWith("fin"))     // true
print("find".beginsWith("find"))    // true
print("find".beginsWith("finder"))  // false

print("find".endsWith("d"))         // true
print("find".endsWith("nd"))        // true
print("find".endsWith("ind"))       // true
print("find".endsWith("find"))      // true
print("find".endsWith(""))          // false

// # Mutating
combined.splice("🐈".characters, atIndex: combined.rangeOfString(smile)!.startIndex)
combined.removeAtIndex(combined.rangeOfString(smile)!.startIndex)
print(combined)                    // Hello 🐈
