import XCTest
import SnapshotTesting

@testable import desafio

class AdsListViewControllerTestCase: XCTestCase {

    var sut: AdsListViewController!

    override func setUp() {
        sut = AdsListViewController()
    }

    override func tearDown() {
        sut = nil
    }

    func testAdsListViewControllerWhenInvocatedShouldHaveCorrectLayout() throws {
        sut.ads = [Ad.dummy(), Ad.dummy(), Ad.dummy(), Ad.dummy()]
        assertSnapshot(matching: sut, as: .recursiveDescription)
    }
}
