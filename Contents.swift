import Foundation
/*:
 # Classes and Structures
 
 ## Learning Outcomes
 
 * understand the difference between classes and structures
 * can describe the difference between a reference and a value type
 * understand the difference between `===` and `==`
 
 ## Goal
 
 This is an introduction to the differences between classes and structures. You will read through apple's documentation on classes and structures and experiment by coding in a playground.
 
 ## Reading
 
 Read Apple's documentation on [Classes and Structures](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html).
 
 
 Read Apple's blog on [Value and Reference Types](https://developer.apple.com/swift/blog/?id=10).
 
 Think about each Self-Reflection quesetion and experiment in the playground help understand what you're reading.
*/
/*:
 - Callout(Self-Reflection):
    * What is the difference between a value type and a reference type?
 
   Value types are passed by value (which means they are effectively (if not technically)) copied with each assignment
  While reference types are passed by reference (which means multiple variables may point at a single instance.)
 
    * Out of classes and structs, which one is a value type and which one is a reference type.
     Structs are value types and classes are reference types.
 */
/*:
 - Experiment:
   What are the final temperature values when Thermometer is a class? 42/42 What are they when Thermometer is a struct? 56/42 In the absence of mutation, why do structs and classes behave the same way? / The question is really 'why do they act differently in the presence of mutation?   And the answer is that in a class, you are setting the same variable twice, and in a struct, you are setting two copies of the same variable.
 */
//class Thermometer {
//  var temperature: Double = 0.0
//  func register(temperature: Double) {
//    self.temperature = temperature
//  }
//}

struct Thermometer {
  var temperature: Double = 0.0
  mutating func register(temperature: Double) {
    self.temperature = temperature
  }
}

var thermometer1 = Thermometer()
thermometer1.register(temperature: 56.0)
var thermometer2 = thermometer1
thermometer2.register(temperature: 42.0)

thermometer1.temperature
thermometer2.temperature
/*:
 - Callout(Self-Reflection):
 * Can classes have properties that are structs?
 * How about the opposite, can structs have properties that are classes?
 */
/*:
 - Experiment:
 Create a struct and an object. What happens when you try to add one as a property of the other?
 */
class Chicken{
  var progeny: Egg? = nil
}

struct Egg{
  var progeny: Chicken? = nil
}

var anEgg = Egg()
var aChickenInstance = Chicken()

anEgg.progeny = aChickenInstance
aChickenInstance.progeny = anEgg

anEgg.progeny
aChickenInstance.progeny

//This seems to work just fine.


/*:
 - Callout(Self-Reflection):
    * What is identity (the `===` operator)? What does it mean when two struct objects or two class objects are identical?
 // === returns true when two instances are identical.  i.e. Two pointers see the same instance of a class
    * What is equivalence (the `==` operator)? How is this different from identity?
 //== returns true when two instances hold indentical data or values.  i.e. two pointers see the same instance OR two instances with identical values
 */
/*:
 - Experiment:
   Create two instances of `User` with the same `username`. What happens when you compare them with `==` and `===`?
 */
class User: Equatable {
  let username: String
  
  init(username: String) {
    self.username = username
  }
  static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username
  }
}

var somePerson: User = User(username:"Frank")
var someOtherPerson: User = User(username:"Frank")

somePerson == someOtherPerson
somePerson === someOtherPerson

/*:
 - Callout(Self-Reflection):
 What is the difference between Swift basic data types (`String`, `Array`, `Dictionary`) vs the data types used commonly in Objective-C (`NSString`, `NSArray`, `NSDictionary`)?
 */
  // These data types are references in objective C, but values in Swift.
/*:
 - Experiment:
 What are the final values in the Swift arrays? What are final values in the Objective-C arrays?
 */

// Swift arrays
var swiftArray1 = [1,2,3,4]
var swiftArray2 = swiftArray1
swiftArray2.append(5)

//Swift array2 has a '5' appended.  It does not affect array1, as these are value types and are thus copied (rather than referenced) upon assignment to each other

// Objective-C arrays
var objectiveCArrray1 = NSMutableArray(array: [1,2,3,4])
var objectiveCArrray2 = objectiveCArrray1
objectiveCArrray2.add(5)

//Obj-C arrays 1 & 2 have an appended '5'.  Both arrays are affected, as these are reference types and are thus pointed at the same data upon assignment to each other

// Final Values:

swiftArray1
swiftArray2

objectiveCArrray1
objectiveCArrray2
/*:
 - Callout(Self-Reflection):
    * What capabilities are common between structs and classes?
 //Both data types hold multiple values, have properties, can include functions
    * What capabilities are different?
  //classes are subject to inheritance, use protocols, and can be instatiated to model individual identity
    * When would you choose to use a class over a struct and the other way around?
 */
 //I would use a class when the model suggests subclassing will be necessary, when instances must communicate using agreed-upon functions, and when separate identity within a type are to be modeled.
 // I would use a struct if multithreading were required, or when it is convenient to assure that assigned values are not indentical.

/*: - Experiment:
  What happenss if you try to subclass a Struct?
 */

//struct Dinosaur{
//}
//
//struct Bird: Dinosaur{
//
//}
// !!! Compiler no likey. !!!

/*: - Experiment:
 Create a new instance of the resolution struct below. You will have to use the automatically-generated memberwise initializer `Resolution(width: ,height:)`. What happens if you change `struct` to `class`?
 */

struct Resolution {
  var width: Int
  var height: Int
}
let smellOVision = Resolution(width:5, height:7)

//The compiler crashes because classes do not get memberwise initializers automatically.
