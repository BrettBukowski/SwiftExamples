import Foundation

class Example {
    var a = 0
    var b: String

    init(a: Int) { // Constructor
        self.a = a
        b = "name"                  // An error if a declared property isn't initialized
    }
}

// External param names are required...
let eg = Example(a: 1)
println(eg.a)              // 1


// ...Unless the params are declared with leading underscores.

class Example2 {
    var a = 0
    var b = 0

    init(_ a: Int, _ b: Int) {
        self.a = a
        self.b = b
    }
}

let eg2 = Example2(1, 2)
println(eg2.a)            // 1
println(eg2.b)            // 2


// # Lazy properties

// Lazy properties' initial value aren't
// initialized until the first time the
// property is accessed.

class Podcast {
    lazy var episode = Episode() // `var` declaration is required.
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

// # Read-only computed properties

class Song {
    var title = ""
    var duration = 0.0
    var metaInfo: [String:String] {
        return [
            "title": self.title,
            "duration": NSString(format: "%.2f", self.duration),
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
        return name[name.startIndex..<advance(name.startIndex, 3)]
    }
}
println(Month(name: "January").shortened())    // Jan

// # Inheritance

// Swift classes do not inherit from a universal base class.

class Bicycle {
    var tireWidth: Double
    var topSpeed: Double
    var name: String
    var gears: Int
    // Marking a method/property with `@final` prevents it from being overridden
    final var color = "green"

    init() {
        tireWidth = 30.5
        topSpeed = 10.0
        name = "regular ol' bike"
        gears = 3
    }

    func go(distance: Double) {
        println("Went \(distance) at a top speed of \(topSpeed) in my \(name)")
    }
}

class MountainBike : Bicycle {
    /* var tireWidth = 64.0 // Cannot override property in the declaration */
    override init() {
        super.init()

        tireWidth = 64.0
        name = "mountain bike"
        gears = 12
    }
    // Override parent's methods via `override` keyword
    override func go(distance: Double) {
        super.go(distance)
        println("Did \(distance) on a mountain bike")
    }

    // A getter/setter override can _any_ inherited property.
    override var topSpeed: Double {
        get {
            return super.topSpeed - 4.0
        }
        set {
            super.topSpeed = newValue
        }
    }

    // Property observer
    override var gears: Int {
        didSet {
            println("Gears was changed to \(gears)")
        }
    }
}

var mountainBike = MountainBike()              // Gears was changed to 12
mountainBike.topSpeed = 6.0
println(mountainBike.topSpeed)                 // 2.0
mountainBike.go(12.0)                          // Went 12.0 at a top speed of 10.0 in my mountain bike
// Did 12.0 on a mountain bike

// # Initializers

// 'Convenience' initializers overload empty
// initializers that populate the params
// in 'designated' initializers.

class iOS {
    var version: String

    init(version: String) {
        self.version = version
    }

    convenience init() {
        self.init(version: "8.0.0")
    }
}

var os = iOS()
println(os.version)                          // 8.0.0

// # ARC and reference cycles

// Strong reference cycles happen when two objects
// hold strong references to each other so that neither
// can be deallocated (à la memory leaks in garbage collected langs)

// Strong references can be resolved by declaring
// references as `weak` or `unowned`

// Use a weak reference whenever it's valid for the reference
// to be nil at any point. These are optional types.

class Driver {
    weak var car: Car? // Strong reference to car.

    deinit {
        println("Driver deinitialized")
    }
}

class Car {
    weak var driver: Driver? // Weak reference to driver.

    deinit {
        println("Car deinitialized")
    }
}

var driver: Driver?
var car: Car?

driver = Driver()
car = Car()
driver!.car = car
car!.driver = driver

driver = nil               // No more strong references to driver.
car = nil                  // No more strong references to car.

// Unowned references are like weak references except they always
// refer to a value, so they're non-nil.

class Artist {
    var instrument: Instrument?  // Strong reference to instrument.
}

class Instrument {
    unowned let artist: Artist   // Unowned reference to artist.
    init (artist: Artist) {
        self.artist = artist
    }
}

var artist: Artist?
artist = Artist()
artist!.instrument = Instrument(artist: artist!)

artist = nil        // Both objects are deallocated since there are no more strong references.

// # Access control

// Access control in Swift is very much package-based.
// `private`: Can only be accessed from the same source file that it's defined
// `internal`: Can be accessed anywhere in the target it's defined
// `public`: Accessible anywhere in the target and anywhere its module is imported

// Defaults to `internal` if not explicitly declared.

internal class Image { // Accessible in the same target
    internal var name : String

    private var mime : String {     // Accessible only in this file. Never settable.
        get {
            return "image/\(name.pathExtension)"
        }
    }

    init(name: String) {
        self.name = name
    }
}
var img = Image(name: "foo.png")

public class Webpage {
    public var title : String
    public var created : NSDate
    private(set) var images : [Image] // Readable within the same target but only writable in this file
    var slug : String {
        return created.description + title
    }

    init(title: String) {
        self.title = title
        self.created = NSDate()
        self.images = []
    }
}

var webPage = Webpage(title: "blog post")
webPage.images.append(Image(name:"panda.gif"))
