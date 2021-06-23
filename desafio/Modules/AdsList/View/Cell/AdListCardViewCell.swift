//
//  AdListCardViewCell.swift
//  desafio
//
//  Created by Fernando Luiz Goulart on 15/04/21.
//

import UIKit

class AdListCardViewCell: UICollectionViewCell, Reusable {

    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLocationLabel: UILabel!
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var adImageContainer: UIView!
    @IBOutlet weak var featuredBadge: UIView!
    @IBOutlet weak var featuredLine: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        addRoundedCorners(withColor: UIColor.white, width: 0.0, radius: 5.0)
    }
    
    //MARK: - Public
    func configure(with adDetail: AdDetail) {
        featuredBadge.backgroundColor = UIColor(rgb: 0x6E0AD6)
        featuredLine.backgroundColor = UIColor(rgb: 0x6E0AD6)
        featuredBadge.isHidden = true
        featuredLine.isHidden = true
        
        titleLabel.text = adDetail.subject
        priceLabel.text = adDetail.prices?.first?.label ?? ""

        if let location = adDetail.getNeighbourhoodLocation(at: adDetail.locations) {
            timeLocationLabel.text = "\(location.label ?? "") - \(adDetail.list_time.formattedTime)"
        }

        guard let thumb = adDetail.thumbnail else { return }
        let imageUrl = "\(String(describing: thumb.base_url))/images/\(String(describing: thumb.path))"
        self.adImageView.downloaded(from: imageUrl)
    }
}
