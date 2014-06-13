var emptyDictionary = Dictionary<String, Float>()

// Type intference allows you to initialize without declaring types:
var strings = [
    "a": "A",
    "b": "B",
]

// # Accessing and assigning elements
println(strings["a"])                           // A
strings["a"] = "AZ"                             // Returns an optional string (new value that was assigned)
strings.updateValue("AX", forKey: "a")          // Returns an optional string (old value that was overwritten)

// Optionals are returned for accessing keys.
if let a = strings["a"] {
    println(a)                                  // AX
}

// # Removing

// Setting the value to nil also removes the key.
strings["a"] = nil
// Using removeValueForKey removes the key-val pair
// but returns the value that was removed (or nil if
// the key-val didn't exist)
strings.removeValueForKey("nope")

// # Updating
strings.updateValue("A", forKey: "a")
strings["a"] = "A"

// # Iterating

for (key, val) in strings {
    println("\(key): \(val)")
}

for key in strings.keys {
    println("KEY: \(key)")
}

for val in strings.values {
    print("VAL: \(val)")                      // VAL: A VAL: B
}

// # Getting all keys & values

let keys = Array(strings.keys)
let vals = Array(strings.values)

// # Clearing everything

strings = [:]

println(strings.count)                         // 0
