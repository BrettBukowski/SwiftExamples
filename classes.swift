class Example {
    var a = 0

    init(a: Int) { // Constructor
        self.a = a
    }
}

// External param names are required here.
let eg = Example(a: 1)
println(eg.a)              // 1

// # Lazy properties

// Lazy properties' initial value aren't
// initialized until the first time the
// property is accessed.

class Podcast {
    @lazy var episode = Episode() // `var` declaration is required.
}

class Episode {
    var audio = "somefile.mp3"
}

var podcast = Podcast()          // episode has not been initialized yet.
println(podcast.episode.audio)   // somefile.mp3

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

// # Ready-only computed properties

class Song {
    var title = ""
    var duration = 0.0
    var metaInfo: Dictionary<String, String> {
        return [
            "title": title,
            "duration": String(duration),
        ]
    }
}

var song = Song()
song.title = "Rootshine Revival"
song.duration = 2.01
println(song.metaInfo["title"]!)    // Rootshine Revival
println(song.metaInfo["duration"]!) // 2.01

// # Property Observers

// Property observers can be added onto any properties
// (including inherited) except for lazy computed props.

class Website {
    var visitors: Int = 0 {             // An explicit type is required
    willSet(newVisitorCount) {          // Called before the prop is set
        visitors = newVisitorCount + 1  // Warning. Can't set within its own willSet
    }
    didSet {                            // Called after a new val is set
        println(visitors - oldValue)    // oldValue is magically defined
    }
    }
}

var site = Website()
site.visitors = 1
println(site.visitors)                 // 1

// # Type Properties
// AKA class variables
class Body {
    /*    class var age = 0                 // error: class variables not yet supported */
    // Computed type property
    class var size: Int {
        return 10
    }
}
println(Body.size)                     // 10

// # Type Methods
// AKA class methods
class Banana {
    var color = "green"
    class func genus() -> String {
        return "Musa"
    }
}
println(Banana.genus())                // Musa

// # Instance methods

class Month {
    var name: String

    init(name: String) {
        self.name = name
    }

    func shortened() -> String {
        return name.substringToIndex(3)
    }
}
println(Month(name: "January").shortened())    // Jan
