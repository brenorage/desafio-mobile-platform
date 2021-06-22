@testable import desafio

class AdsListPresenterStub: AdsListPresenterProtocol {
    var ads: [Ad] = [Ad.dummy(), Ad.dummy(), Ad.dummy(), Ad.dummy()]

    var getAdsListWasCalled = false
    func getAdsList() {
        getAdsListWasCalled = true
    }
}
