import XCTest
import SnapshotTesting

@testable import desafio

class AdsListViewControllerTestCase: XCTestCase {

    var sut: AdsListViewController!
    var presenterStub: AdsListPresenterStub!

    override func setUp() {
        presenterStub = AdsListPresenterStub()
        sut = AdsListViewController(presenter: presenterStub)
        buildWindow(with: sut)
    }

    override func tearDown() {
        sut = nil
        presenterStub = nil
    }

    func testAdsListViewControllerWhenInvocatedShouldHaveCorrectLayout() throws {
        assertSnapshot(matching: sut, as: .recursiveDescription)
    }

    func testAdsListViewControllerWhenLoadedShouldCallGetAdsList() {
        sut.viewDidLoad()
        XCTAssertTrue(presenterStub.getAdsListWasCalled)
    }
}
