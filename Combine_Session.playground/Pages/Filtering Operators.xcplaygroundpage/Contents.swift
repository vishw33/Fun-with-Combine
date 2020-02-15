//: [Transform Operators](@previous)

import Foundation
import Combine


var examplePublisher = [20 ,1,3,4,5,10,20,15,17,19].publisher
var subscriptions = Set<AnyCancellable>()

_ = examplePublisher.collect().sink(receiveValue: { (val) in
    print("examplePublisher = \(val)")
})

//: Filtering operators

//: ## filter(_:)
//: ![](filter.png)
//: “takes a closure returning a Bool and only passes down values that match the provided predicate”
_ = examplePublisher
    .filter{$0%2 == 0}
    .sink(receiveValue: { (val) in
    print(val)
})

//: ## removeDuplicates()
//: ![](RM.png)
let words = "hey hey there! want to listen to mister mister ?"
                  .components(separatedBy: " ")
                  .publisher
_ =   words
    .removeDuplicates()
    .collect()
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)

//: ## compactMap(_:)
//: ![](CM.png)
let compactPublisher = ["1","a","b","2","3","5.79"].publisher
_ = compactPublisher.compactMap {
    Int($0)
}.sink(receiveValue: { (val) in
    print(val)
})

//: ## ignoreOutput()
//: ![](IO.png)
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

//: # Finding values
//: ## first(where:)
//: ![](FW.png)

_ = examplePublisher
    .first(where: {$0%2 == 0})
    .sink(receiveCompletion: { (completion) in
        switch completion {
        case .finished:
            print("Found Value")
        }
    }, receiveValue: { (val) in
        print("Value is = \(val)")
    })

//: ## last(where:)
//: ![](LW.png)
_ = examplePublisher
    .last(where: { (val) -> Bool in
        val%2 == 0
    })
    .sink(receiveCompletion: { (completion) in
        switch completion {
        case .finished:
            print("Found Value")
        }
    }, receiveValue: { (val) in
        print("Value is = \(val)")
    })

//: # Dropping values
//: ## dropFirst(_:)
//: ![](DF.png)

_ = examplePublisher
    .dropFirst(3)
    .collect()
    .sink(receiveCompletion: { (completion) in
         switch completion {
         case .finished:
             print("Dropped Value")
         }
     }, receiveValue: { (val) in
         print("Value after dropped = \(val)")
     })

//: ## dropWhile(_:)
//: ![](DW.png)
_ = examplePublisher
    .drop(while: { (val) -> Bool in
        val%5 != 0
    })
    .collect()
    .sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("Dropped While Completed")
            }
        }, receiveValue: { (val) in
            print("Value after While dropped = \(val)")
        })

//: ## drop(untilOutputFrom:)
//: ![](DU.png)
let isReady = PassthroughSubject<Void, Never>()
let dropUntilPub = PassthroughSubject<Int, Never>()

_ = dropUntilPub
    .drop(untilOutputFrom: isReady)
    .sink(receiveCompletion: { (completion) in
        switch completion {
        case .finished:
            print("Dropped While Completed")
        }
    }, receiveValue: { (val) in
        print("Value after While dropped = \(val)")
    })

(1...5).forEach { n in
    dropUntilPub.send(n)
    
    if n == 3 {
        isReady.send()
    }
}

//: # Limiting values
//: ## prefix(_:)
//: ![](PreF.png)
_ = examplePublisher
    .prefix(2)
    .collect()
    .sink(receiveCompletion: { (completion) in
           switch completion {
           case .finished:
               print("Prefix Completed")
           }
       }, receiveValue: { (val) in
           print("Value of prefix = \(val)")
       })
   
//: ## prefix(while:)
//: ![](PW.png)
_ = examplePublisher
    .prefix(while: { (val) -> Bool in
        val < 10
    })
.collect()
.sink(receiveCompletion: { (completion) in
       switch completion {
       case .finished:
           print("Prefix Completed")
       }
   }, receiveValue: { (val) in
       print("Value of prefix While= \(val)")
   })

//: ## prefix(untilOutputFrom:)
//: ![](pU.png)

_ = dropUntilPub
    .prefix(untilOutputFrom: isReady)
    .sink(receiveCompletion: { (completion) in
        switch completion {
        case .finished:
            print("Prefix While Completed")
        }
    }, receiveValue: { (val) in
        print("Value after While dropped = \(val)")
    })

(1...5).forEach { n in
    dropUntilPub.send(n)
    
    if n == 3 {
        isReady.send()
    }
}

//: [Combining Operators](@next)
