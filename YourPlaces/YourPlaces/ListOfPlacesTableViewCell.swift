//
//  ListOfPlacesTableViewCell.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 21.05.17.
//
//

import UIKit

class ListOfPlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var imageViewPlacePhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.layoutMargins = UIEdgeInsets.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
