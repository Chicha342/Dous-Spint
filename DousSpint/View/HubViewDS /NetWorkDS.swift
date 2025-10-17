import Foundation

struct Response: Decodable {
    let url: String
}

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .decodingError:
            return "Failed to decode response"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

final class NetWorkDS {
    static let shared = NetWorkDS()
    
    private init() {
        
    }
    
    private let baseURL = "https://codemind.top/v1/public/install"
        
    func fetchInstallURL(bundle: String) async throws -> Response {
        guard let url = URL(string: baseURL) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["bundle": bundle]
        request.httpBody = try JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    return try JSONDecoder().decode(Response.self, from: data)
                } catch {
                    throw APIError.decodingError
                }
            case 403, 404:
                throw APIError.serverError(httpResponse.statusCode)
            default:
                throw APIError.serverError(httpResponse.statusCode)
            }
            
        } catch {
            throw APIError.unknown(error)
        }
    }
}
