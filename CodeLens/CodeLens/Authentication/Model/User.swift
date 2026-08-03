import Foundation

struct User: Codable {
    let uid: String
    let name: String
    let email: String
    let password: String
    let timeStamp: TimeInterval
}
