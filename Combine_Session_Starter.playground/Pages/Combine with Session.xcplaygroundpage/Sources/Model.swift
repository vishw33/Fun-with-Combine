import Foundation

public enum HTTPError: LocalizedError {
    case statusCode
    case post
}

public struct Post: Codable {

    let id: Int
   public let title: String
    let body: String
    let userId: Int
}

public struct Todo: Codable {

    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
}
