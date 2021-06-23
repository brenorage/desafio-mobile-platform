import Foundation
import UIKit.UIImage

protocol ImageServiceProtocol {
    func getImage(with thumb: AdThumbnail, completion: @escaping RequestCallback<UIImage>)
}

final class ImageService: ImageServiceProtocol {

    private let httpServices: HTTPServicesProtocol

    init(httpServices: HTTPServicesProtocol = HTTPServices()) {
        self.httpServices = httpServices
    }

    func getImage(with thumb: AdThumbnail, completion: @escaping RequestCallback<UIImage>) {
        guard
            let url = URL(string: "\(String(describing: thumb.base_url))/images/\(String(describing: thumb.path))")
        else {
            completion(.failure(.badRequest))
            return
        }

        httpServices.downloadData(from: url) { result in
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.badFormat))
                    return
                }
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
