import Foundation
import Combine

//: [Previous](@previous)

//: # Subscribers
//: - a subscriber _subscribes_ to receive publisher's values

//:  ## Currently Combine has 2 in built Subscribers

/*:
 - Sink
 - Assign
*/


//: ![](Sub.png)

let publisher = ["Hello Combine"].publisher


let subscriber = Subscribers.Sink<String ,Never>(receiveCompletion: { (completion) in
        switch completion {
    case .finished:
        print("Finished")
    case .failure(_):
        print("Failed")
    }
}) { (val) in
    print("string :-  \(val)")
}

//:  Publisher subscribes to subscribers

publisher.subscribe(subscriber)


//: [Next](@next)
