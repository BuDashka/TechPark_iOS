//
//  PlaceFaveTableViewCell.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 29.05.17.
//
//

import UIKit

class PlaceFaveTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.layoutMargins = UIEdgeInsets.zero
        
        imageViewPlace.sd_setShowActivityIndicatorView(true)
        imageViewPlace.sd_setIndicatorStyle(.white)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
