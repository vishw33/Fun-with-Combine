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
_ = examplePublisher
.prepend(-2,-1,0)
.collect()
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("Prepend Completed")
    }
}, receiveValue: { (val) in
    print("Value after Prepend = \(val)")
})

//: ## prepend(sequence:)
//: ![](PS.png)
_ = examplePublisher
.prepend([-11,-12,0])
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("Prepend sequence Completed")
    }
}, receiveValue: { (val) in
    print("Value after Prepend sequence = \(val)")
})

//: ## prepend(publisher:)
//: ![](PP.png)

let anotherPublisher = [0,0,0,0,0].publisher
_ = examplePublisher
.prepend(anotherPublisher)
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("Prepend Publisher Completed")
    }
}, receiveValue: { (val) in
    print("Value after Prepend Publisher = \(val)")
})

//: ## append(_:)
//: ![](App.png)
_ = examplePublisher
.append(-2,-1,0)
.collect()
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("append Completed")
    }
}, receiveValue: { (val) in
    print("Value after append = \(val)")
})

//: ## append(sequence:)
//: ![](AS.png)
_ = examplePublisher
.append([-11,-12,0])
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("append sequence Completed")
    }
}, receiveValue: { (val) in
    print("Value after append sequence = \(val)")
})

//: ## append(publisher:)
//: ![](AP.png)
_ = examplePublisher
.append(anotherPublisher)
.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("append Publisher Completed")
    }
}, receiveValue: { (val) in
    print("Value after append Publisher = \(val)")
})

//: [Advanced Operators](@next)
