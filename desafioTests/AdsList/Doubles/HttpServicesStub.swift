@testable import desafio

class HttpServicesStub: HTTPServicesProtocol {

    var successDecodable: Decodable?
    var error: NetworkError?
    var calledEndpoint: EndpointProtocol?

    func request<T: Decodable>(endpoint: EndpointProtocol, completion: @escaping RequestCallback<T>) {
        calledEndpoint = endpoint

        if let successDecodable = successDecodable {
            completion(.success(successDecodable as! T))
        } else if let error = error {
            completion(.failure(error))
        }
    }

    var cancelTasksWasCalled = false
    func cancelTasks() {
        cancelTasksWasCalled = true
    }
}
