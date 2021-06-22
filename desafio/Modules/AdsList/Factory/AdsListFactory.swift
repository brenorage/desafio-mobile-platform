
struct AdsListFactory {
    static func createAdsList() -> AdsListViewController {
        let presenter = AdsListPresenter()
        let controller = AdsListViewController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}
