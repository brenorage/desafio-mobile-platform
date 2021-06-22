import Foundation
@testable import desafio

enum EndpointMock: EndpointProtocol {

    case mock
    
    var scheme: EndpointScheme { return .https }
    var httpMethod: HTTPMethod { return .get }
    var host: String { return "google.com.br" }
    var path: String { return "" }
    var parameters: [URLQueryItem] { return [] }
}
