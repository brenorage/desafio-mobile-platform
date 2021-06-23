import Foundation

typealias RequestCallback<T> = (Result<T, NetworkError>) -> Void
public typealias HeadersParams = [String : String]

protocol HTTPServicesProtocol {
    func request<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping RequestCallback<T>)
    func downloadData(from url: URL, completion: @escaping RequestCallback<Data>)
    func cancelTasks()
}

extension HTTPServicesProtocol {
    func cancelTasks() { }
}
