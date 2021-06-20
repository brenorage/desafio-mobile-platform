//
//  AdsListViewController.swift
//  desafio platforms
//
//  Created by Fernando Luiz Goulart on 13/04/21.
//

import UIKit

class AdsListViewController: UIViewController {

    // Mark: properties

    var ads: [Ad] = []

    let session = URLSession.shared
    let url = URL(string: "https://nga.olx.com.br/api/v1.2/public/ads?lim=25&region=11&sort=relevance&state=1&lang=pt")!

    private let flowLayout = AdListViewLayout()

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

    override func loadView() {
        view = adsCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAds()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: REST
    
    private func getAds() {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            // Check the response
            print(response)
            if error != nil {
                print(error)
                return
            }
            // Serialize the data into an object
            do {
                let json = try JSONDecoder().decode(ListAds.self, from: data! )
                print(json)
                self.ads = json.list_ads ?? []
                DispatchQueue.main.async {
                    self.adsCollectionView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }

}

// MARK: UICollectionViewDataSource

extension AdsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell: AdListCardViewCell = collectionView.dequeueReusableCell(indexPath: indexPath),
            !ads.isEmpty
        else {
            return UICollectionViewCell()
        }
        cell.configure(ad: ads[indexPath.row])
        return cell
    }
}
