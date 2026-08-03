import Foundation

final class APIServiceManager {
    
    static let shared = APIServiceManager()
    
    private init() {
        
    }
    
    func initiateAPICall<T: Decodable>(with endPoint: String, requestInput: RequestInput, method: Method) async throws -> T {
        
        let apiUrl = APIConfiguration.baseURL + endPoint
        
        guard let url = URL(string: apiUrl) else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = try JSONEncoder().encode(requestInput)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch response.statusCode {
            case 200...299:
                return try JSONDecoder().decode(T.self, from: data)
            case 400...409:
                
                if let error = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    throw APIError.api(error.message)
                }
                
                switch response.statusCode {
                case 401:
                    throw APIError.unauthorized
                case 403:
                    throw APIError.forbidden
                case 404:
                    throw APIError.invalidURL
                default:
                    throw APIError.invalidResponse
                }
            case 500...599:
                throw APIError.serverError
            default:
                throw APIError.invalidResponse
            }
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw APIError.networkConnectionLost
            case .timedOut:
                throw APIError.api("Request time out.")
            default:
                throw APIError.serverError
            }
        }
    }
}

protocol RequestInput: Codable {}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case noInternt
    case networkConnectionLost
    case forbidden
    case unauthorized
    case invalidResponse
    case decodingError(Error)
    case notFound
    case serverError
    case api(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL."
        case .noInternt:
            "No internet connection."
        case .networkConnectionLost:
            "Network Connection Lost."
        case .forbidden:
            "Access denied."
        case .unauthorized:
            "Unauthorized."
        case .invalidResponse:
            "Unexpected response from server."
        case .decodingError(let error):
            error.localizedDescription
        case .notFound:
            "Resource not found."
        case .serverError:
            "Server error. Please try again later."
        case .api(let message):
            message
        case .unknown(let error):
            error.localizedDescription
        }
    }
}
