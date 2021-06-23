import UIKit.UINib

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
    static var bundle: Bundle? { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        let nibName = String(describing: self)
        guard bundle?.path(forResource: nibName, ofType: "nib") != nil else {
            return nil
        }

        return UINib(nibName: String(describing: self), bundle: bundle)
    }

    static var bundle: Bundle? {
        return Bundle(for: self)
    }
}
