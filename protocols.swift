// AKA Interfaces in other languages:
// abstract properties and methods that
// concrete classes implement.

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
    var mimetype: String

    func save() {

    }

    mutating func resize(width: Double, height: Double) {

    }
}
