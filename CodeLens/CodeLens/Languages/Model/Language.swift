import Foundation

struct Language: Codable, Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var isAvailable: Bool
    var languageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case isAvailable
        case languageExtension = "extension"
    }
}
