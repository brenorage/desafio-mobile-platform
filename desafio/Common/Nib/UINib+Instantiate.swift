import class UIKit.UINib

extension UINib {
    func instantiate(owner: AnyObject? = nil) -> Any? {
        return instantiate(withOwner: owner, options: nil).first
    }
}
