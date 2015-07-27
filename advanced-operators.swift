import Foundation

// # Bitwise Operators

var a: UInt8 = 0b00001111
var b: UInt8 = 0b11110000

// `NOT`
print(~a == b)                   // true

// `AND`
print(a & b == 0)                // true

// `OR`
print(a | b == 0b11111111)       // true

// `XOR`
print(a ^ b == a | b)            // true

// Shifts (unsigned)
print(a << 1 == 0b00011110)
print(a >> 1 == 0b00000111)

// # Overflow Operators

// Normally Swift will error when and over/under
// flow occurs.

var num = UInt8.max
// error: arithmetic operation results in an overflow
/* var zero = num + 1 */

// But prefixing the operator with "&" tells Swift
// that you want this behavior.
var zero = num &+ 1
print(zero == 0)                 // true

// # Operator Functions

// Operator overloading is a supported language feature,
// but it isn't a best practice in most cases.

struct Trip {
    var distance = 0.0, duration = 0.0
}

// Defines an 'infix' + operator that handles two args.
func + (left: Trip, right: Trip) -> Trip {
    return Trip(distance: left.distance + right.distance,
        duration: left.duration + right.duration)
}
// Defines a 'prefix' - operator that handles a single arg.
prefix func - (trip: Trip) -> Trip {
    return Trip(distance: trip.distance * -1.0, duration: trip.duration * -1.0)
}

// Compound assignments are also supported.

func += (inout left: Trip, right: Trip) {
    left = left + right
}

// As well as assignment expressions.
prefix func ++ (inout trip: Trip) -> Trip {
    trip += Trip(distance: 1.0, duration: 1.0)
    return trip
}

var tripA = Trip(distance: 100.0, duration: 2.0)
var tripB = Trip(distance: 250.0, duration: 5.0)

var combined = tripA + tripB

print("Went \(combined.distance) in \(combined.duration)")        // Went 350.0 in 7.0

var disaster = -tripA

print("Went \(disaster.distance) in \(disaster.duration)")        // Went -100.0 in -2.0

tripA += tripB
tripA += tripB

print("Went \(tripA.distance) in \(tripA.duration)")        // Went 600.0 in 12.0

++tripA

print("Went \(tripA.distance) in \(tripA.duration)")        // Went 601.0 in 13.0


// You can also define your own bananas custom operators with
// / = - + * % < > ! & | ^ . ~

postfix operator -=- {}

postfix func -=- (inout trip: Trip) -> Trip {
    trip = Trip(distance: Double(Int(trip.distance) * random()),
        duration: Double(Int(trip.duration) * random()))
    return trip
}

tripA-=-

print("Went \(tripA.distance) in \(tripA.duration)")        // Went 602222301.0 in 1311110111.0
