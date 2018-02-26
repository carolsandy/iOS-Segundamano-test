//
//  ViewControllerTableViewCell.swift
//  Segundamano-test
//
//  Created by Adriana on 2/26/18.
//  Copyright © 2018 Segundamano.mx. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var uiImageDog: UIImageView!
    @IBOutlet weak var uiNameDog: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
