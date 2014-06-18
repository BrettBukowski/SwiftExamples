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

// # Arrays

// Arrays are not copied immediately...

var bands1 = ["radiohead", "telekinesis", "nada surf"]
var bands2 = bands1
println(bands1 === bands2)          // true

bands1[0] = "the orwells"
println(bands2[0])                  // the orwells

// ...Until one of the references modifies the length of the array
bands1.append("cut copy")
bands1[0] = "carla morrison"
println(bands2[0])                  // the orwells

// Or the original reference can call `unshare`
var wiBands = ["phox", "bon iver"]
var coBands = wiBands

wiBands.unshare()

wiBands[0] = "PHOX"
coBands[0] = "DeVotchKa"
coBands[1] = "the lumineers"

println(wiBands)                   // [PHOX, bon iver]
println(coBands)                   // [DeVotchKa, the lumineers]

// Or `copy` will create a copy
var otherCOBands = coBands.copy()
otherCOBands[0] = "paper bird"

println(otherCOBands[0])          // paper bird
println(coBands[0])               // DeVotchKa
