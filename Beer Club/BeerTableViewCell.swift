//
//  BeerTableViewCell.swift
//  Beer Club
//
//  Created by DeShawn Brown on 4/27/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    
    @IBOutlet var beerNameLabel: UILabel!
    
    @IBOutlet var beerImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
