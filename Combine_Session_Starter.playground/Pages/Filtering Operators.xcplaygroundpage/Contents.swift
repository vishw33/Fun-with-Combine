//: [Transform Operators](@previous)

import Foundation
import Combine


var examplePublisher = [1,3,4,5,10,20,15,17,19].publisher
var subscriptions = Set<AnyCancellable>()

_ = examplePublisher.collect().sink(receiveValue: { (val) in
    print("examplePublisher = \(val)")
})

//: Filtering operators

//: ## filter(_:)
//: ![](filter.png)
//: “takes a closure returning a Bool and only passes down values that match the provided predicate”

//: ## removeDuplicates()
//: ![](RM.png)
let words = "hey hey there! want to listen to mister mister ?"
                  .components(separatedBy: " ")
                  .publisher

//: ## compactMap(_:)
//: ![](CM.png)
let compactPublisher = ["1","a","b","2","3","5.79"].publisher


//: ## ignoreOutput()
//: ![](IO.png)
_ = examplePublisher


//: # Finding values
//: ## first(where:)
//: ![](FW.png)



//: ## last(where:)
//: ![](LW.png)


//: # Dropping values
//: ## dropFirst(_:)
//: ![](DF.png)



//: ## dropWhile(_:)
//: ![](DW.png)


//: ## drop(untilOutputFrom:)
//: ![](DU.png)
let isReady = PassthroughSubject<Void, Never>()
let dropUntilPub = PassthroughSubject<Int, Never>()



//(1...5).forEach { n in
//    dropUntilPub.send(n)
//
//    if n == 3 {
//        isReady.send()
//    }
//}

//: # Limiting values
//: ## prefix(_:)
//: ![](PreF.png)

   
//: ## prefix(while:)
//: ![](PW.png)

//: ## prefix(untilOutputFrom:)
//: ![](pU.png)



//(1...5).forEach { n in
//    dropUntilPub.send(n)
//    
//    if n == 3 {
//        isReady.send()
//    }
//}

//: [Combining Operators](@next)
