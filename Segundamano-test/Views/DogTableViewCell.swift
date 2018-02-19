//
//  DogTableViewCell.swift
//  Segundamano-test
//
//  Created by Jonathan Pabel on 19/02/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit
import AlamofireImage

class DogTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var dogItem:DogModel! {
        didSet{
            configureCell()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dogImageView.image = #imageLiteral(resourceName: "placeholder_dog")
    }
    
    func configureCell() {
        titleLabel.text = dogItem.name
        
        if let coverURl = dogItem.coverURL {
            if let imageURL = URL(string: coverURl) {
                dogImageView.af_setImage(withURL: imageURL, imageTransition: UIImageView.ImageTransition.crossDissolve(0.2))
            }
        }
    }
    
}
