@testable import desafio

final class AdsListServiceStub: AdsListServiceProtocol {

    var adsList: [Ad]?
    var error: NetworkError?

    func getAdsList(completion: @escaping RequestCallback<[Ad]>) {
        if let ads = adsList {
            completion(.success(ads))
        } else if let error = error {
            completion(.failure(error))
        }
    }
}
