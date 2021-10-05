//
//  BeerTableViewCell.swift
//  BearShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    @IBOutlet var imageV: CachableUIImageView!
    @IBOutlet var titleL: UILabel!
    @IBOutlet var tagLineL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(element:Any) {
        if let element = element as? BeerElement {
            titleL.text = element.name ?? ""
            tagLineL.text = element.tagline ?? ""
            guard let url = URL(string: element.imageURL ?? "") else { return }
            imageV.downloadImageFrom(url: url, imageMode: .scaleAspectFit)

        }
    }
}
