class Example {
    var a = 0

    init(a: Int) {
        self.a = a
    }
}

// External param names are required here.
let eg = Example(a: 1)
println(eg.a)              // 1
