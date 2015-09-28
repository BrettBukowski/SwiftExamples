let i = 7

switch i {
case 1:
    print("one")
case 2:
    print("two")
case 3, 4:
    // Comma-separate multiple expressions in the same case statement.
    print("three or four")
case _ where i > 5:
    print("greater than 5")
default:
    // Default is required.
    print("less than 1")
}

// Switch on the result of a function.

func isEven (int: Int) -> Bool {
    return int % 2 == 0
}

switch isEven(i) {
    case true: print("Even")
    case false: print("Odd")
}
