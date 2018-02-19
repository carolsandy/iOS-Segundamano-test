//
//  DogDetailTableViewCell.swift
//  Segundamano-test
//
//  Created by Jonathan Pabel on 19/02/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit
import AlamofireImage

class DogDetailTableViewCell: UITableViewCell {

   
    @IBOutlet weak var dogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var itemImage:String! {
        didSet{
            configureCell()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = #imageLiteral(resourceName: "placeholder_dog")
    }
    
    private func configureCell() {
        if let coverURl = itemImage {
            if let imageURL = URL(string: coverURl) {
                dogImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2))
            }
        }
    }
}
