//: [Subscriber](@previous)
import Foundation
import Combine
//:  # Subjects
/*:
 - A subject is both a subscriber and a publisher ...
 - ... relays values it receives from other publishers ...
 - ... can be manually fed with new values
 */
//:  ## Two type of subjects
//: ### Passthrough Subject
//: ### CurrentValue Subject

//: # Passthrough Subject
//: ### Start your code


let subscriber = Subscribers.Sink<Int,Never>(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("Finisher")
    case .failure(_):
        print("Failed")
    }
}) { (val) in
    print("EmittedValue:- \(val)")
}



//passSubject.send(10)
//passSubject.send(20)
//passSubject.send(completion: .finished)
//passSubject.send(30)

//: subjects can use sink directly



//: # Current Value Subject

//: These are same as Passthrough Subject but initilised with initial value
//: also we can access last emitted value through the property

//: Get value by below property


//: Rest as same as Passthrough Subject , can use both Sink and Assign to get value


//: [Operators](@next)
