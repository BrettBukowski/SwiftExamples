let i = 2

switch i {
case 1:
    print("one")
case 2:
    print("two")
case 3, 4:
    // Comma-separate multiple expressions in the same case statement.
    print("three or four")
default:
    // Default is required.
    print("huh")
}
