//: [Advance Operators](@previous)

import Foundation
import Combine

//: # Basic Session Coading

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        fatalError("Error: \(error.localizedDescription)")
    }
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        fatalError("Error: invalid HTTP response code")
    }
    guard let data = data else {
        fatalError("Error: missing response data")
    }

    do {
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)
        print("Normal \(posts.count)")
    }
    catch {
        print("Error: \(error.localizedDescription)")
    }
}
task.resume()

//: #  Session Coading with Combine

private var cancellable: AnyCancellable?
cancellable = URLSession.shared.dataTaskPublisher(for: url)
.map { $0.data }
.decode(type: [Post].self, decoder: JSONDecoder())
.replaceError(with: [])
.eraseToAnyPublisher()
.sink(receiveValue: { posts in
    print("combine \(posts.count)")
})

//: #  Session Coading with Combine with Error Handling

var cancellableError = URLSession.shared.dataTaskPublisher(for: url)
.tryMap { output in
    guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
        print("ERRRRRROR")
        throw HTTPError.statusCode
    }
    return output.data
}
.decode(type: [Post].self, decoder: JSONDecoder())
.eraseToAnyPublisher()
.sink(receiveCompletion: { completion in
    switch completion {
    case .finished:
        break
    case .failure(let error):
        fatalError("This is description = \(error.localizedDescription)")
    }
}, receiveValue: { posts in
    print("Error Handling = \(posts.count)")
})

//: # using Assign
class Example {
public var posts: [Post] = [] {
      didSet {
          print("posts --> \(posts.count)")
      }
  }
}
let obj = Example()

var cancellableAssign = URLSession.shared.dataTaskPublisher(for: url)
    .map{$0.data}
    .decode(type: [Post].self, decoder: JSONDecoder())
.replaceError(with: [])
.eraseToAnyPublisher()
    .assign(to: \.posts, on: obj)


//: # Grouping multiple requests
let url1 = URL(string: "https://jsonplaceholder.typicode.com/posts")!
let url2 = URL(string: "https://jsonplaceholder.typicode.com/todos")!

let publisher1 = URLSession.shared.dataTaskPublisher(for: url1)
.map { $0.data }
.decode(type: [Post].self, decoder: JSONDecoder())

let publisher2 = URLSession.shared.dataTaskPublisher(for: url2)
.map { $0.data }
.decode(type: [Todo].self, decoder: JSONDecoder())

let cancellableGroup = Publishers.Zip(publisher1, publisher2)
.eraseToAnyPublisher()
.catch { _ in
    Just(([], []))
}
.sink(receiveValue: { posts, todos in
    print(posts.count)
    print(todos.count)
})


//: [Customization](@next)
