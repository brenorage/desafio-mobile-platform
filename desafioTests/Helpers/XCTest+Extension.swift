import XCTest

extension XCTest {
    func buildWindow(with viewController: UIViewController) {
        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
