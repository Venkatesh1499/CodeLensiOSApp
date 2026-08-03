import Foundation

enum Envirornment {
    case uat
    case production
}

struct APIConfiguration {
    
    static let shared = APIConfiguration()
    
    static private let environment: Envirornment = .production
    
    private init() {
        
    }
    
    static var baseURL: String {
        switch self.environment {
        case .uat:
            return "http://0.0.0.0:5000/api/v1"
        case .production:
            return "https://codelensbackend-production-e816.up.railway.app/api/v1"
        }
    }
}

struct EndPoint {
    static let review = "/review"
    static let format = "/format"
}
