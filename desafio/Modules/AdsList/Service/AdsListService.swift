import Foundation

protocol AdsListServiceProtocol {
    func getAdsList(completion: @escaping RequestCallback<[Ad]>)
}

final class AdsListService: AdsListServiceProtocol {

    private let httpServices: HTTPServicesProtocol

    init(httpServices: HTTPServicesProtocol = HTTPServices()) {
        self.httpServices = httpServices
    }

    func getAdsList(completion: @escaping RequestCallback<[Ad]>) {
        let endpoint = AdsListEndpoint()
        httpServices.request(endpoint: endpoint) { (result: Result<ListAds, NetworkError>) in
            switch result {
            case let .success(listAds):
                guard let ads = listAds.list_ads else { return completion(.success([])) }
                completion(.success(ads))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
