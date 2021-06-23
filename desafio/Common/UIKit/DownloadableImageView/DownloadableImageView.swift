import UIKit

final class DownloadableImageView: UIImageView {

    private let imageService: ImageServiceProtocol

    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func downloadImage(to thumb: AdThumbnail) {
        imageService.getImage(with: thumb) { result in
            switch result {
            case let .success(image):
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            case .failure:
                print("erro ao baixar imagem")
            }
        }
    }
}
