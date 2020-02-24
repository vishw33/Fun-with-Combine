//: [Previous](@previous)

import Foundation
import Combine

//: ## Publisher Protocol
//: ![](PPL.png)
/*:
- The type of values that the publisher can produce.
- The type of error a publisher may produce, or Never if the publisher is guaranteed to not produce an error.
- A subscriber calls subscribe(_:) on a publisher to attach to it.
- The implementation of subscribe(_:) will call receive(subscriber:) to attach the subscriber to the publisher, i.e., create a subscription.
 */

//: ## Subscriber Protocol
//: ![](SPC.png)
/*:
 - The type of values a subscriber can receive.
 - The type of error a subscriber can receive; or Never if the subscriber won’t receive an error.
 - The publisher calls receive(subscription:) on the subscriber to give it the subscription.
 - The publisher calls receive(_:) on the subscriber to send it a new value that it just published.
 - The publisher calls receive(completion:) on the subscriber to tell it that it has finished producing values, either normally or due to an error.
 */

//: # Creating a custom subscriber

let publisher = (1...6).publisher

final class IntSubscriber:Subscriber {
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value", input)
              return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }
}
let subscriber = IntSubscriber()
publisher.subscribe(subscriber)
//: [Next](@next)
