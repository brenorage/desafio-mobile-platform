import Foundation

final class JSONParseHelper {
    class func getObject<T: Decodable>(from jsonFile: String)-> T {

        guard let path = Bundle(for: JSONParseHelper.self).path(forResource: jsonFile, ofType: "json") else {
            fatalError("file not found / name: \(jsonFile)")
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("malformed json / error: \(error)")
        }
        
    }
}
