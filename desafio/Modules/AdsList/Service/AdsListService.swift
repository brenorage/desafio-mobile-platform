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
        httpServices.request(endpoint: endpoint, completion: completion)
    }
}
