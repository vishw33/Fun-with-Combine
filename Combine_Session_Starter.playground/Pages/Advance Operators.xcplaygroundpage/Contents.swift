//: [Combining Operator](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

//: ## switchToLatest()
//: ![](STL.png)
let pub1 = PassthroughSubject<Int,Never>()
let pub2 = PassthroughSubject<Int,Never>()
let pub3 = PassthroughSubject<Int,Never>()
let examplePublisher = PassthroughSubject<PassthroughSubject<Int,Never>,Never>()
    
examplePublisher
.switchToLatest()
    .sink(receiveCompletion: { _ in print("Completed!") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

  examplePublisher.send(pub1)
pub1.send(0)
pub1.send(1)
examplePublisher.send(pub2)
pub1.send(2)
pub2.send(3)
pub1.send(completion: .finished)

//: ## mergewith()
//: ![](MP.png)
let publisher1 = PassthroughSubject<Int,Never>()
let publisher2 = PassthroughSubject<Int,Never>()

publisher1.merge(with: publisher2).sink { (val) in
    print("merged value =\(val)")
}
publisher1.send(1)
publisher2.send(11)
publisher2.send(12)
publisher1.send(2)
publisher1.send(3)
publisher2.send(13)
//publisher1.send(completion: .finished)
//publisher2.send(completion: .finished)

//: ## combineLatest(with:)
//: ![](CL.png)
let p1 = PassthroughSubject<Int,Never>()
let p2 = PassthroughSubject<String,Never>()

p1.combineLatest(p2).sink(receiveCompletion: { _ in print("Completed") },
          receiveValue: { print("P1: \($0), P2: \($1)") })
    .store(in: &subscriptions)
p1.send(1)
p2.send("a")
p2.send("b")
p1.send(2)

p1.send(completion: .finished)
p2.send(completion: .finished)

//: ## zip()
//: ![](Zip.png)
let z1 = PassthroughSubject<Int,Never>()
let z2 = PassthroughSubject<String,Never>()
z1.zip(z2).sink(receiveCompletion: { _ in print("Completed") },
          receiveValue: { print("P1: \($0), P2: \($1)") })
    .store(in: &subscriptions)
z1.send(1)
z2.send("a")
z2.send("b")
z1.send(2)
z1.send(3)
z1.send(4)
z2.send("c")

z1.send(completion: .finished)
z2.send(completion: .finished)




//: [DataTask Publisher](@next)
