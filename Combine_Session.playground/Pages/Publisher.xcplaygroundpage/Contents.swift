import Combine
import Foundation

//: [Before Combine](@previous)
//: # Publishers
//: - A Publisher _publishes_ values ...
//:  ## Publisher can :-
/*:
 - An output value of the publisher's generic Output type.
 - A successful completion.
 -  A completion with an error of the publisher's Failure type.
*/

//: ![](PublisherInt.png)

let array = [1,2,3,4].publisher

//: [Subscriber](@next)
