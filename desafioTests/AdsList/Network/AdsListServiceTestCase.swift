import XCTest

@testable import desafio

class AdsListServiceTestCase: XCTestCase {

    var sut: AdsListService!
    var httpServicesStub: HttpServicesStub!

    override func setUp() {
        httpServicesStub = HttpServicesStub()
        sut = AdsListService(httpServices: httpServicesStub)
    }

    override func tearDown() {
        sut = nil
        httpServicesStub = nil
    }

    func testGetAdsListWhenWasCalledShouldCallCorrectEndpoint() {
        sut.getAdsList { _ in }

        XCTAssertEqual(httpServicesStub.calledEndpoint?.path, "ads")
    }


    func testGetAdsListWhenResultWasSuccessShouldReturnAdsList() {
        httpServicesStub.successDecodable = [Ad.dummy()]
        var adSubject = ""

        let getAdsListExpectation = expectation(description: "Callback getAdsList")
        sut.getAdsList { result in
            switch result {
            case let .success(ads):
                adSubject = ads.first?.ad.subject ?? "Assunto vazio"
            case .failure:
                XCTFail("It was expected a success")
            }
            getAdsListExpectation.fulfill()
        }

        wait(for: [getAdsListExpectation], timeout: 0.3)
        XCTAssertEqual(adSubject, "TV retrô softselector      110.00")
    }

    func testGetAdsListWhenResultWasFailureShouldReturnError() {
        httpServicesStub.error = NetworkError.internalError
        var receivedError = NetworkError.unknown

        let getAdsListExpectation = expectation(description: "Callback getAdsList")
        sut.getAdsList { result in
            switch result {
            case .success:
                XCTFail("It was expected a failure")
            case let .failure(error):
                receivedError = error
            }
            getAdsListExpectation.fulfill()
        }

        wait(for: [getAdsListExpectation], timeout: 0.3)
        XCTAssertEqual(receivedError, NetworkError.internalError)
    }
}
