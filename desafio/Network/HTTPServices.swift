import Foundation

class HTTPServices {

    private let networkSession: NetworkSession

    init(networkSession: NetworkSession = NetworkSessionImpl()) {
        self.networkSession = networkSession
    }
}

extension HTTPServices: HTTPServicesProtocol {
    func request<T : Decodable>(endpoint: EndpointProtocol, completion: @escaping RequestCallback<T>) {
        cancelTasks()

        guard let url = endpoint.url else {
            completion(.failure(.unknown))
            return
        }

        networkSession.makeTask(with: url, httpMethod: endpoint.httpMethod.rawValue) { data, urlResponse, error in
            if  let error = error {
                let nsError = error as NSError
                completion(.failure(self.parseError(with: nsError.code)))
                return
            }

            if  let response = urlResponse as? HTTPURLResponse,
                !Array(200...300).contains(response.statusCode) {
                completion(.failure(self.parseError(with: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.badFormat))
                return
            }

            self.treatSuccess(data: data, completion: completion)
        }
    }
    
    func cancelTasks() {
        networkSession.task?.cancel()
    }

    private func treatSuccess<T: Decodable>(data: Data, completion: RequestCallback<T>) {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            completion(.success(object))
        }
        catch {
            completion(.failure(.badFormat))
        }
    }

    func parseError(with code: Int) -> NetworkError {
        switch code {
        case NSURLErrorNotConnectedToInternet:
            return .notConnected
        case NSURLErrorTimedOut:
            return .timeout
        case 400...499:
            return .badRequest
        case 500...599:
            return .internalError
        default:
            return .unknown
        }
    }
}
