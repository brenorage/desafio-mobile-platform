import Foundation

enum NetworkError: Error {
    case notConnected
    case timeout
    case badRequest
    case internalError
    case badFormat
    case unknown

    var title: String {
        switch self {
        case .notConnected:
            return "Atenção"
        default:
            return "Algo deu errado"
        }
    }

    var message: String {
        switch self {
        case .notConnected:
            return "Parece que você está sem conexão no momento."
        default:
            return "Estamos com problemas, tente novamente."
        }
    }
}
