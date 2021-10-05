//
//  BeerDetailsVC.swift
//  BearShop
//
//  Created by Sushobhit.Jain on 05/10/21.
//

import UIKit

class BeerDetailsVC: UIViewController {

    @IBOutlet var imageV: CachableUIImageView!
    @IBOutlet var titleL: UILabel!
    @IBOutlet var taglineL: UILabel!
    @IBOutlet var descriptionL: UILabel!
    
    var viewModel:BeerDetailViewModel = BeerDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    func setUpView() {
        guard let element = self.viewModel.beer else { return }
        titleL.text = element.name ?? ""
        taglineL.text = element.tagline ?? ""
        descriptionL.text = element.BeerDescription ?? ""
        guard let url = URL(string: element.imageURL ?? "") else { return }
        imageV.downloadImageFrom(url: url, imageMode: .scaleAspectFit)
    }
    
}
