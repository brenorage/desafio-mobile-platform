import Foundation

struct AdsListEndpoint: EndpointProtocol {
    var scheme: EndpointScheme {
        .https
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var host: String {
        "nga.olx.com.br"
    }

    var path: String {
        "/api/v1.2/public/ads"
    }

    var parameters: [URLQueryItem] {
        [
            URLQueryItem(name: "lim", value: "25"),
            URLQueryItem(name: "region", value: "11"),
            URLQueryItem(name: "sort", value: "relevance"),
            URLQueryItem(name: "state", value: "1"),
            URLQueryItem(name: "lang", value: "pt")
        ]
    }
}
