import Foundation
@testable import desafio

final class NetworkSessionMock: NetworkSession {
    var task: URLSessionDataTask? = nil
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    func makeTask(with url: URL, httpMethod: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, urlResponse, error)
    }
}
