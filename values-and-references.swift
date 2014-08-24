// # Classes are reference types

class Job {
    var title = ""
}

var job1 = Job()
var job2 = job1
job1.title = "singer"
println(job2.title)                   // singer

// Triple equals checks identity.
println(job1 === job2)                // true

// # Dictionaries are copied at the point of assignment

var band1 = ["bob": "singer", "dan": "guitarist"]
var band2 = band1

band2["bob"] = "drummer"
println(band1["bob"])                // singer

// # Arrays, Strings, and Dictionaries

// Arrays, Strings, and Dictionaries are implemented as structs,
// so they're copied when they're assigned to a new constant or
// variable, or when they'e passed to a function / method

var bands1 = ["radiohead", "telekinesis", "nada surf"]
var bands2 = bands1
println(bands1 == bands2)           // true

bands1[0] = "the orwells"
// Now `bands2` is a separate copy.
println(bands2[0])                  // radiohead
