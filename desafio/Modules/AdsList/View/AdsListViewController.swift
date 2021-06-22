//
//  AdsListViewController.swift
//  desafio platforms
//
//  Created by Fernando Luiz Goulart on 13/04/21.
//

import UIKit

protocol AdsListViewProtocol: class {
    func reloadData()
    func showError(with message: String)
}

class AdsListViewController: UIViewController {

    private lazy var adsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .lightGray
        collectionView.clipsToBounds = true
        collectionView.isOpaque = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AdListCardViewCell.self)
        return collectionView
    }()

    private let flowLayout = AdListCollectionViewLayout()
    private let presenter: AdsListPresenterProtocol

    override func loadView() {
        view = adsCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getAdsList()
    }

    init(presenter: AdsListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdsListViewController: AdsListViewProtocol {
    func reloadData() {
        adsCollectionView.reloadData()
    }

    func showError(with message: String) {
        print(message)
    }
}

// MARK: UICollectionViewDataSource

extension AdsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell: AdListCardViewCell = collectionView.dequeueReusableCell(indexPath: indexPath),
            let ad = presenter.ads[safe: indexPath.item]
        else {
            return UICollectionViewCell()
        }
        cell.configure(ad: ad)
        return cell
    }
}
