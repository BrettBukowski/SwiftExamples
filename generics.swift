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

// # Where clauses

// You can impose more rigorous conformance between types using
// a `where` clause after the list of type params within the brackets.

var a = ["a"]
println(a.dynamicType)
println(object_getClassName(a))

protocol Container {
    typealias Thing
    func size() -> Int
    func add(thing: Thing)
}

class Crate<Thing> : Container {
    var items = [Thing]()

    func size() -> Int {
        return items.count
    }

    func add(thing: Thing) {
        items.append(thing)
    }
}

func similarCrates<C1: Container, C2: Container where C1.Thing == C2.Thing> (crate1: C1, crate2: C2) -> Bool {
    return crate1.size() == crate2.size()
}

var stringCrate = Crate<String>()
stringCrate.add("stickers")

var intCrate = Crate<Int>()
intCrate.add(22)

// This fails: 'String' is not identical to 'Int'
/* similarCrates(stringCrate, intCrate) */

var anotherStringCrate = Crate<String>()
similarCrates(stringCrate, anotherStringCrate)                 // false
anotherStringCrate.add("goo")
similarCrates(stringCrate, anotherStringCrate)                 // true
