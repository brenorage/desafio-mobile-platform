import XCTest
import Foundation

@testable import desafio

final class HttpServicesTest: XCTestCase {
    let url = URL(string: "http://www.google.com")!
    let json = ["string": "test"]

    var sut: HTTPServices!
    var networkSession: NetworkSessionMock!

    override func setUp() {
        networkSession = NetworkSessionMock()
        sut = HTTPServices(networkSession: networkSession)
    }

    override func tearDown() {
        sut = nil
        networkSession = nil
    }

    func testRequestWhenReceivesSuccessShouldParseCorrectly() {
        let mockModel = MockModel(string: "test")

        networkSession.urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: [:])
        networkSession.data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

        var result: Result<MockModel, NetworkError>!

        sut.request(endpoint: EndpointMock.mock) { result = $0 }

        XCTAssertEqual(result, .success(mockModel))
    }

    func testRequestWhenReceivesErrorShouldParseCorrectly() {
        networkSession.urlResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: [:])
        networkSession.data = nil
        networkSession.error = nil

        var result: Result<MockModel, NetworkError>!

        sut.request(endpoint: EndpointMock.mock) { result = $0 }

        XCTAssertEqual(result, .failure(.internalError))
    }

    func testRequestWhenReceivesConnectionErrorShouldParseCorrectly() {
        networkSession.urlResponse = nil
        networkSession.data = nil
        networkSession.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: [:])

        var result: Result<MockModel, NetworkError>!

        sut.request(endpoint: EndpointMock.mock) { result = $0 }

        XCTAssertEqual(result, .failure(.notConnected))
    }
}
