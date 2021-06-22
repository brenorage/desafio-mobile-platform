import Foundation

protocol AdsListPresenterProtocol {
    var ads: [Ad] { get }

    func getAdsList()
}

final class AdsListPresenter: AdsListPresenterProtocol {

    var ads: [Ad] = []
    weak var view: AdsListViewProtocol?

    private let adsListService: AdsListServiceProtocol

    init(adsListService: AdsListServiceProtocol = AdsListService()) {
        self.adsListService = adsListService
    }

    func getAdsList() {
        adsListService.getAdsList { [weak self] result in
            switch result {
            case let .success(ads):
                self?.ads = ads
                self?.view?.reloadData()
            case let .failure(error):
                self?.view?.showError(with: error.message)
            }
        }
    }
}
