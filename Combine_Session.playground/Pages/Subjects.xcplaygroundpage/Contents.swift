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
let passSubject = PassthroughSubject<Int,Never>()

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

passSubject.subscribe(subscriber)

//passSubject.send(10)
//passSubject.send(20)
//passSubject.send(completion: .finished)
//passSubject.send(30)

//: subjects can use sink directly
passSubject.sink(receiveCompletion: { (completion) in
    switch completion {
    case .finished:
        print("Subject Finished")
     case .failure(_):
           print("Subject Failed")
    }
}) { (val) in
    print("Subject Emitted:- \(val)")
}

passSubject.send(10)
//: [Next](@next)
