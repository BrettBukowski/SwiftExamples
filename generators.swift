import Foundation

// `GeneratorType` is a type of `SequenceType`.
// In order to conform, set the Element
// typealias and implement the `next`
// method.

class Incrementing : GeneratorType {
    typealias Element = Int
    var counter = 0

    func next() -> Element? {
        return counter++
    }
}

var count = Incrementing()
count.next()!                         // 0
count.next()!                         // 1


// `for` loops work with any `SequenceType` type.
// A `SequenceType` has a `generate` method that
// returns a `GeneratorType`.

class Fibonacci : SequenceType {
    func generate() -> GeneratorOf<Int> {
        var current = 0
        var next = 1

        return GeneratorOf<Int> {
            var returnVal = current
            current = next
            next += returnVal

            return returnVal
        }
    }
}

var fibSequence = Fibonacci()

for i in fibSequence {
    if i > 50 {
        break
    }

    print("\(i) ")                // 0 1 1 2 3 5 8 13 21 34
}
