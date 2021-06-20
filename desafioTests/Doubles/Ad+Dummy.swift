@testable import desafio

extension Ad {
    static func dummy() -> Ad {
        let ad: Ad = JSONParseHelper.getObject(from: "Ad")
        return ad
    }
}
