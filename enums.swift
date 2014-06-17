enum Example {
    case A
    case B
    case C
    case D
}

// Unlike enums in other languages, the named labels
// do not implicitly map to 0, 1.. etc. enum members
// are their own values of the type specified by the
// enum's name.

var example = Example.A          // (Enum Value)

// Once you assign to an enum value, you can reassign
// to another value without respecifying the the enum
// name.

example = .B

// Switch statements must be exhaustive or declare
// a default case.

switch example {
case .A:
    println("A")
case .B:
    println("B")                               // B
case .C:
    println("C")
case .D:
    println("D")
}

// Enumerations can store values of any type, and
// type values can be different for every enum member.

enum Types {
    case Str(String)
    case Num(Double)
}

// A variable can be reassigned a different type of the
// enum.
var a = Types.Str("hello")
a = .Num(1.0)

// Associated values can be extracted as part of a switch.
switch a {
case .Str(let val):
    println(val)
case .Num(let val):
    println(val)                             // 1.0
}

// # Raw Values

// Enums can prepopulate with "raw" values, similar to other
// languages.
enum Letters: Character {
    case a = "A"
    case b = "B"
    case c = "C"
}

// When integers are used for raw values, they
// auto-increment if no value is specified.
enum Numbers: Int {
    case One = 1, Two, Three, Four, Five
}

// Access raw values with `toRaw`

var five = Numbers.Five
println(five.toRaw())                      // 5

// `fromRaw` tries to find an enum member with a raw value.
// An optional is returned.

var possibleNum = Numbers.fromRaw(2)!
println(possibleNum == Numbers.Two)       // true
