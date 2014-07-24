import Foundation

// Generic functions can operate on any type

// Type parameters specify a placeholder type
// in brackets after the function name.
// Thereafter, that placeholder can be used
// as a type parameter or within the function.
func log<ToBeLogged>(a: ToBeLogged) {
    println(a)
}

log("les filles")
log(1)
