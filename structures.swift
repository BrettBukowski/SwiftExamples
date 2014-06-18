// Structs are copy by value, can't inherit, but can
// conform to protocols

struct Work {
  var location = ""
  var units = String[]()
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
