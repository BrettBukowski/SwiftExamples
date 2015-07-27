// AKA Interfaces in other languages:
// abstract properties and methods that
// concrete classes implement.

import Foundation

protocol Image {
    // Protocol defines only a properties'
    // type and whether it's gettable or settable
    var filename: String { get set }
    var filesize: Double { get }
    var mimetype: String { get }
    var height: Double { get }
    var width: Double { get }

    /*    class var someTypeProperty: Int { get set } */

    func save ()

    mutating func resize(width: Double, height: Double)
}

// Structs can adopt protocols...

struct Gif : Image {
    var filename: String
    var filesize: Double
    var mimetype = "image/gif"
    var height: Double
    var width: Double

    func save() {

    }

    mutating func resize(width: Double, height: Double) {

    }
}

// ...or Classes can adopt protocols...

class Png : Image {
    var filename: String
    var filesize: Double
    var mimetype = "image/png"
    var height: Double
    var width: Double

    init(filename: String, filesize: Double, width: Double, height: Double) {
        self.filename = filename
        self.filesize = filesize
        self.width = width
        self.height = height
    }

    func save() {

    }

    // `mutating` is not required when the protocol already
    // declares it as such.
    func resize(width: Double, height: Double) {

    }
}

var gif = Gif(filename: "rainbow.gif", filesize: 2.3, mimetype: "image", height: 50, width: 50)
var png = Png(filename: "carry.png", filesize: 3.4, width: 100, height: 54)


// Protocols are full-fledged types

func resizeImage (var img: Image) {
    img.resize(50.0, height: 50.0)
}

// Protocols are heavily used as part of the delegate pattern
// so that classes can call delegates' hook methods during certain
// lifecycle events.

// # Protocol Composition

// A type can be composed of multiple protocols.

protocol Video {
    var framerate: Int { get }
    var resolution: Double { get }
}


struct Media: Image, Video {
    var filename: String
    var filesize: Double
    var mimetype: String
    var height: Double
    var width: Double
    var framerate: Int
    var resolution: Double

    func save() {

    }

    func resize(width: Double, height: Double) {

    }
}

// Each protocol is comma-separated within brackets.
func save(media: protocol<Image, Video>) {
    media.save()
}

// # Protocol Checking

// `is` and `as` work as on any other type.

// # Optional Protocol Requirements

// Denoted with `@optional`.

// This feature requires protocols be marked
// with `@objc`, which exposes the protocol
// to Objective-C code.
@objc protocol Time {
    var day: Int { get }
    var month: Int { get }
    var year: Int { get }
    optional var hour: Int { get }
    optional var minute: Int { get }
    optional var second: Int { get }

    func toString () -> String
}

class ShortDate : Time {
    @objc var day: Int
    @objc var month: Int
    @objc var year: Int

    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }

    @objc func toString () -> String {
        return "\(day)/\(month)/\(year)"
    }
}

class LongDate : ShortDate {
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0

    convenience init(day: Int, month: Int, year: Int, hour: Int, minute: Int, second: Int) {
        self.init(day: day, month: month, year: year)
        self.hour = hour
        self.minute = minute
        self.second = second
    }

    override func toString() -> String {
        return super.toString() + " \(hour):\(minute):\(second)"
    }
}

var dates: [AnyObject] = [
    ShortDate(day: 5, month: 5, year: 2016),
    LongDate(day: 5, month: 5, year: 2016, hour:10, minute:1, second: 0)
]

for item in dates {
    let date = item as! Time

    print("\(date.toString())")                              // 5/5/2016 5/5/2016 10:1:0

    if let hours = date.hour {
        print("Hour of the day: \(hours)")                  // Hour of the day: 10
    }
}

