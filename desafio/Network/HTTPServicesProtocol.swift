import Foundation

typealias RequestCallback<T> = (Result<T, NetworkError>) -> Void
public typealias HeadersParams = [String : String]

protocol HTTPServicesProtocol {
    func request<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping RequestCallback<T>)
    func cancelTasks()
}

extension HTTPServicesProtocol {
    func cancelTasks() { }
}
