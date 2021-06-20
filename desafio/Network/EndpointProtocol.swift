import Foundation

protocol EndpointProtocol {
    var scheme: EndpointScheme { get }
    var httpMethod: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
}

extension EndpointProtocol {
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.queryItems = parameters
        return components.url
    }
}

enum EndpointScheme: String {
    case http = "http"
    case https = "https"
}

enum HTTPMethod: String {
    case get = "GET"
}
