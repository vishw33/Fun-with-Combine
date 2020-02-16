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

//: [Next](@next)
