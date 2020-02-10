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

//: ![](flatmap.png)
//: ## flatMap(maxPublishers:_:)

struct User {
   let name: CurrentValueSubject<String, Never>
}

let userSubject = PassthroughSubject<User, Never>()
        
userSubject
   .map { $0.name } // 🛑 Oops, compilation error here
   .sink { print($0) }

let user = User(name: .init("Me"))
userSubject.send(user)

//:  # Replacing Up Stream
//: ![](ReplaceNil.png)
//: ## replaceNil(with:)
//: replace the upstream value with given value

let nilArray = [1,nil,2,nil].publisher
_ = nilArray.replaceNil(with: -1).sink(receiveValue: { (val) in
    print(val)
})
//: one place Map can be explained better
_ = nilArray.replaceNil(with: -1).map{
    Int($0)
}.sink(receiveValue: { (val) in
    print(val)
})

//: ![](ReplaceEmpty.png)
//: ## replaceEmpty(with:)
//: replace the upstream value with given value
let empty = Empty<Int, Never>()
  
  // 2
  empty
.replaceEmpty(with: 10)
    .sink(receiveCompletion: { print($0) },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

//: ![](Scan.png)
//: ## scan(_:_:)
//: It will provide the current value emitted by an upstream publisher to a closure, along with the last value returned by that closure
_ = publisher.scan(0){
    $0 + $1
}.sink(receiveValue: { (val) in
    print(val)
})

//: [Filtering Operator](@next)
