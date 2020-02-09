//: [Subjects](@previous)

import Foundation
import Combine

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
var subscriptions = Set<AnyCancellable>()

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
func square(val:Int) -> Int {
    return val * val
}

_ = publisher.map{
    square(val: $0)
    }.collect().sink(receiveValue: { (val) in
    print(val)
})
//: ## tryMap(_:)
//: Try Map is same as map but it gives room for error handling and send another publisher in case of error

//: ## Just error Example
Just("Directory name that does not exist")
    .tryMap { try FileManager.default.contentsOfDirectory(atPath: $0) }
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)



//: [Filtering Operator](@next)
