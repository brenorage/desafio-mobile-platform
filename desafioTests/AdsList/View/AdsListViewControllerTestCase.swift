import XCTest
import SnapshotTesting

@testable import desafio

class AdsListViewControllerTestCase: XCTestCase {

    var sut: AdsListViewController!

    override func setUp() {
        isRecording = true
        sut = AdsListViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdsListViewControllerWhenInvocatedShouldHaveCorrectLayout() throws {
        sut.ads = [Ad.dummy()]
        assertSnapshot(matching: sut, as: .image)
    }
}
