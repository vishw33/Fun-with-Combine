//: [Filtering Operators](@previous)

import Foundation
import Combine

//: # Combine Operators
//: ## “Combining operators. This set of operators lets you combine events emitted by different publishers”

var examplePublisher = [1,3,4,5,10,20,15,17,19].publisher
var subscriptions = Set<AnyCancellable>()

_ = examplePublisher.collect().sink(receiveValue: { (val) in
    print("examplePublisher = \(val)")
})

//: ## prepend(_:)
//: ![](Pre.png)


//: ## prepend(sequence:)
//: ![](PS.png)


//: ## prepend(publisher:)
//: ![](PP.png)

let anotherPublisher = [0,0,0,0,0].publisher


//: ## append(_:)
//: ![](App.png)


//: ## append(sequence:)
//: ![](AS.png)


//: ## append(publisher:)
//: ![](AP.png)


//: [Advanced Operators](@next)
