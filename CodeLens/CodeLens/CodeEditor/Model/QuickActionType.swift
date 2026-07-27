import Foundation

enum QuickActionType: Int {
    case selectAll = 0
    case paste = 1
    case clear = 2
    case format = 3
}

struct QuickAction {
    let type: QuickActionType
    let value: String
}

struct CodeDetails: RequestInput {
    let language: String
    let code: String
    
    init(language: String, code: String) {
        self.language = language
        self.code = code
    }
}

struct APIErrorResponse: Codable {
    let message: String
    let statusCode: Int
}
