// When you add an extension to an existing type,
// the extension changes are available on existing
// instances of that type, even if they were declared
// before the extension.

var someInt = 3

extension Int {
    func isOdd () -> Bool{
        return self % 2 != 0
    }

    func isEven() -> Bool {
        return !isOdd()
    }

    func times(task: (Int)->()) {
        for i in 0..<self {
            task(i)
        }
    }
}

print(someInt.isOdd())                 // true
print(2.isEven())                      // true

2.times({(Int i) in
    print(i)                           // 0, 1
})
