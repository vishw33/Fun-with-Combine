//: [Subjects](@previous)

import Foundation

//: # Operators
//: ![](Operators.png)
//: ## Operators are publishers
/*:
 - methods that perform an operation on values coming from a publisher are called operators.
 - Each Combine operator actually returns a publisher
 */

//:  # Collect
//: ![](collect.png)
//: ## collect()
//: collect operator will collect all the value emitted my publisher

var publisher = [1,2,3,4,5].publisher

//: WithOut Operator
_ = publisher.sink(receiveValue: { (val) in
    print(val)
})

//: using Operator

_ = publisher
    .collect()
    .sink(receiveValue: { (val) in
        print(val)
    })

//:  # Mapping Values
//: ![](Map.png)
//: ## map(_:)
//: collect operator will collect all the value emitted my publisher

//: [Filtering Operator](@next)
