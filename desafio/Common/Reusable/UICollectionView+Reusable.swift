import Foundation
import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        let reuseIdentifier = T.reuseIdentifier
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T
    }
}
