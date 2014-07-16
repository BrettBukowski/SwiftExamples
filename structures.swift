// Structs are copy by value, can't inherit, but can
// conform to protocols

struct Work {
  var location = ""
  var units = [String]()
  let length: Int

  func last() -> String {
    return units[units.count - 1]
  }
}

// Structs have handy memberwise initializers.
// All properties must be specified.
var work = Work(location: "office", units: ["answer phone", "read book"], length: 8)

println(work.location)                // office
println(work.units[0])                // answer phone
println(work.last())                  // read book

// # Type Properties
// AKA static variables

struct Play {
    static var duration = 1
    static var name: String { // Read-only computed type property
        return String("named \(duration + 1)")
    }
    static var activity: String {
        get {
            return name + "stargaze"
        }
        mutating set {
            duration = 2
        }
    }
}
println(Play.duration)               // 1
println(Play.name)                   // named 2
println(Play.activity)               // named 2stargaze

// # Instance methods

struct Mansion {
    var rooms = 30
    var garageDoors = 5

    // Methods cannot modify value types without
    // declaring so via the `mutating` keyword.
    mutating func addGarage (newVal: Int) {
        garageDoors += newVal
    }
}
var mansion = Mansion()
mansion.addGarage(5)
println(mansion.garageDoors)         // 10

// # Type Methods
// AKA static methods

struct Font {
    static var size = 12
    var typeface = ""

    static func pointSize() -> String {
        return "\(size)pt"
    }
}
println(Font.pointSize())            // 12pt
