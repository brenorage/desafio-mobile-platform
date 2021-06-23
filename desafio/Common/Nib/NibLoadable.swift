import struct CoreGraphics.CGGeometry.CGRect

import class UIKit.UIView
import class Foundation.NSCoder

protocol NibLoadble: Reusable { }

extension NibLoadble where Self: UIView {
    static func instantiate() -> Self {
        func instantiateUsingNib<T: UIView>() -> T {
            guard let nib = nib else { fatalError("Could not find a nib for \(self).") }

            guard let view = nib.instantiate() as? T else {
                fatalError("The nib \(nib) expected its root view to be of type \(self).")
            }

            return view
        }

        return instantiateUsingNib()
    }

    @discardableResult func loadViewFromNib() -> UIView {
        guard let nib = Self.nib else { fatalError("Could not find a nib for \(self).") }

        guard let view = nib.instantiate(owner: self) as? UIView else {
            fatalError("The nib \(nib) expected to have a root view and \(self) as owner.")
        }

        view.frame = self.frame
        addSubview(view)

        return view
    }
}
