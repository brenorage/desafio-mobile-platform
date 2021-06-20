import Foundation

protocol NetworkSession {
    var task: URLSessionDataTask? { get set }
    func makeTask(with url: URL, httpMethod: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class NetworkSessionImpl: NetworkSession {
    var task: URLSessionDataTask?
    private let urlSession = URLSession.shared
    
    func makeTask(with url: URL, httpMethod: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        task = urlSession.dataTask(with: urlRequest, completionHandler: completionHandler)
        task?.resume()
    }
}
