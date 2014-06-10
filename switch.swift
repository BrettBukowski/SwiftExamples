let i = 2

switch i {
case 1:
    println("one")
case 2:
    println("two")
case 3, 4:
    // Comma-separate multiple expressions in the same case statement.
    println("three or four")
default:
    // Default is required.
    println("huh")
}

// two
