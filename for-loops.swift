// # Half-Closed range operator
// Defines a range that doesn't
// include the last number.
for index in 1..<5 {
    print(index)           // 1 2 3 4
}

// # Closed-Range operator
// Defines a range that
// includes the last number.
for index in 1...5 {
    print(index)           // 1 2 3 4 5
}

// Traditional for loop.
for var i = 0; i < 5; i++ {
    print(i)               // 0 1 2 3 4
}
