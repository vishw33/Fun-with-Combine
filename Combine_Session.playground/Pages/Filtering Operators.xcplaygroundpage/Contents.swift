//: [Transform Operators](@previous)

import Foundation
import Combine


var examplePublisher = [1,3,4,5,10,20,15,17,19].publisher
var subscriptions = Set<AnyCancellable>()

//: Filtering operators

//: ![](filter.png)
//: ## filter(_:)
//: “takes a closure returning a Bool and only passes down values that match the provided predicate”
_ = examplePublisher
    .filter{$0%2 == 0}
    .sink(receiveValue: { (val) in
    print(val)
})

//: ![](RM.png)
//: ## removeDuplicates()
let words = "hey hey there! want to listen to mister mister ?"
                  .components(separatedBy: " ")
                  .publisher
_ =   words
    .removeDuplicates()
    .collect()
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)

//: ![](CM.png)
//: ## compactMap(_:)
let compactPublisher = ["1","a","b","2","3","5.79"].publisher
_ = compactPublisher.compactMap {
    Int($0)
}.sink(receiveValue: { (val) in
    print(val)
})

//: ![](IO.png)
//: ## ignoreOutput()
_ = examplePublisher
.ignoreOutput()
    .sink(receiveCompletion: { (completion) in
        switch completion {
        case .finished:
            print("Ignored output completly")
        }
    }, receiveValue: { (val) in
        print("Value is = \(val)")
    })

//: [Next](@next)
