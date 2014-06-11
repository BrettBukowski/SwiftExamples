func simple() {
    println("hi")
}

simple()                                // hi


// Parameter types and the return type must be specified.
func plus(a: Int, b: Int) ->Int {
    return a + b
}

// Functions can return tuples.
func stats(numbers: Int[]) -> (min: Int, max: Int) {
    var min = Int.max, max = Int.min

    for i in numbers {
        if i < min {
            min = i
        }
        if i > max {
            max = i
        }
    }

    return (min, max)
}

var result = stats([1, 2, 4])
println(result.min)                      // 1
println(result.max)                      // 4

// Named parameters use an 'external' name before the 'internal' name.
// Kind of a kludgy holdover from Obj-C selectors...
func increment(number: Int, by incrementer: Int) -> Int {
    return number + incrementer
}

println(increment(1, by: 10))           // 11

// ...So fortunately there's a shorthand for re-using the same name.
// (unfortunately it's ugly)
func incrementTakeTwo(number: Int, #by: Int) -> Int {
    return number + by
}

println(increment(1, by: 10))           // 11

// Default parameter values.
// Swift realizes that the verbosity is becoming a burden.
// So default params' internal names are also auto-exposed
// with the same external name.
func incrementTakeThree(number: Int, by: Int = 3) -> Int {
    return number + by
}

println(incrementTakeThree(1))         // 4
println(incrementTakeThree(1, by:1))   // 2
