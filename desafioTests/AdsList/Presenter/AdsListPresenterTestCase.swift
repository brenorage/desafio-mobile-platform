import XCTest
import SnapshotTesting

@testable import desafio

class AdsListPresenterTestCase: XCTestCase {

    var sut: AdsListPresenter!
    var serviceStub: AdsListServiceStub!
    var viewSpy: AdsListViewSpy!

    override func setUp() {
        serviceStub = AdsListServiceStub()
        viewSpy = AdsListViewSpy()
        sut = AdsListPresenter(adsListService: serviceStub)
        sut.view = viewSpy
        
    }

    override func tearDown() {
        sut = nil
        serviceStub = nil
        viewSpy = nil
    }

    func testGetAdsListWhenReceivesSuccessShouldReturnsAdsList() throws {
        serviceStub.adsList = [Ad.dummy(), Ad.dummy()]
        sut.getAdsList()
        XCTAssertEqual(sut.ads.count, 2)
        XCTAssertTrue(viewSpy.reloadDataWasCalled)
    }

    func testGetAdsListWhenReceivesFailureShouldCallShowError() throws {
        serviceStub.error = .internalError
        sut.getAdsList()
        XCTAssertTrue(viewSpy.showErrorWasCalled)
    }
}
