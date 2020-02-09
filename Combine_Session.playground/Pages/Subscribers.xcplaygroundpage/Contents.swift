import Foundation
import Combine

//: [Publisher](@previous)
//: # Subscribers
//: - a subscriber _subscribes_ to receive publisher's values
//:  ## Currently Combine has 2 in built Subscribers
/*:
 - Sink
 - Assign
*/

//: ![](Sub.png)

//: ### Start your code
let publisher = ["Hello Combine"].publisher

let subscriber = Subscribers.Sink<String ,Never>(receiveCompletion: { (completion) in
        switch completion {
    case .finished:
        print("Finished")
    case .failure(_):
        print("Failed")
    }
}) { (val) in
    print("string Value :-  \(val)")
}

//:  Publisher subscribes to subscribers
publisher.subscribe(subscriber)

//: Subscriber can be subscribed to only one publisher
let  publisher2 = ["Combine Again!"].publisher
publisher2.subscribe(subscriber)

/*:
## The rules of a subscription
- A subscriber will receive a _single_ subscription
- _Zero_ or _more_ values can be published
- At most _one_ completion will be called
- After completion, nothing more is received
*/
//: [Understanding](@next)
