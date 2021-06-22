@testable import desafio

final class AdsListViewSpy: AdsListViewProtocol {

    var reloadDataWasCalled = false
    func reloadData() {
        reloadDataWasCalled = true
    }

    var showErrorWasCalled = false
    func showError(with message: String) {
        showErrorWasCalled = true
    }
}
