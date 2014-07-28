import Foundation

// Generic functions can operate on any type.
//
// Type parameters specify a placeholder type
// in brackets after the function name.
// Thereafter, that placeholder can be used
// as a type parameter or within the function.
func log<ToBeLogged>(a: ToBeLogged) {
    println(a)
}

log("les filles")
log(1)

// # Generic Types

// Generic types are your own structs, classes,
// and enums that work with any type.

// This is how all of Swift's built-in types work.

struct Bucket<Bucketable> {
    var items = [Bucketable]()

    mutating func add(item: Bucketable) {
        items.append(item)
    }

    mutating func remove() {
        items = []
    }
}

var bucket = Bucket<Int>()
bucket.add(1)

var bucket2 = Bucket<String>()
bucket2.add("special")

class Basket<Basketable> {
    var items = [Basketable]()

    func add(item: Basketable) {
        items.append(item)
    }

    func remove() {
        items = []
    }
}

var basket = Basket<Int>()
basket.add(1)

var basket2 = Basket<String>()
basket2.add("control")

// # Type Constraints

// You can ensure that a generic type
// conforms to a protocol or is a subclass
// of a specific type.

// Without adding the `Equatable` type constraint,
// the compiler doesn't know whether `==` will work
// and thus won't compile this func.
func equal<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

// # Associated Types

// Protocols can define placeholder names (aliases)
// to types that are used as part of the protocol.

protocol Vase {
    typealias Plant
    mutating func add(item: Plant)
    var size: Int { get set }
    mutating func remove() -> Plant
}

class GrecianUrn : Vase {
    typealias Plant = String

    var size = 10
    var plantName = ""

    func add(item: String) {
        plantName = item
    }

    func remove() -> String {
        var name = plantName
        plantName = ""
        return name
    }
}
