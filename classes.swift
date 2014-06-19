class Example {
    var a = 0

    init(a: Int) {
        self.a = a
    }
}

// External param names are required here.
let eg = Example(a: 1)
println(eg.a)              // 1

// # Lazy properties

// Lazy properties' initial value isn't
// initialized until the first time the
// property is accessed.

class Podcast {
    @lazy var episode = Episode() // `var` declaration is required.
}

class Episode {
    var audio = ""
}

// # Computed properties

// Computed properties don't store a value. Instead, getters / setters
// are provided to retrieve and set _other_ properties.

class Window {
    var x = 0.0, y = 0.0
    var width = 100.0, height = 100.0

    var center: (Double, Double) {
    get {
        return (width / 2, height / 2)
    }

    set(newVal) {
        x = newVal.0 - (width / 2)
        y = newVal.1 - (height / 2)
    }
    }
}

var win = Window()
println(win.center)               // (50.0, 50.0)
win.center = (0.0, 10.0)
println(win.x)                    // -50.0
println(win.y)                    // -40.0

// The param to `set` can be omitted and a magic "newValue"
// can be used to referenced the new value.
/*
set {
    x = newValue.0 - (width / 2)
}
*/

