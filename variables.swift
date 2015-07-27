var yo = 1.0
yo++
yo += 1
print(yo)                      // 3.0

// Cannot redeclare variables
/* var yo = 2.0 // 'yo' previously declared here */
// Cannot change its type
/* yo = "yo" // cannot convert the expression's tyoe '()' to type 'Double' */

// Declare multiple variables on one line, separated by commas
var a = 1.0, b = 2.0, c = 3.0
print(a + b + c)              // 6.0

// Declare the var's type if not immediately assigning a value.
var hey: String
/* print(hey)                  // variable 'hey' used before being initialized */
hey = "there"
print(hey)                    // there

// Emoji var names
var 🐮 = "ridiculous"
print(🐮)                    // ridiculous
