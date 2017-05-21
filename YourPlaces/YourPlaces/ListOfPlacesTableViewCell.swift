//
//  ListOfPlacesTableViewCell.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 21.05.17.
//
//

import UIKit

class ListOfPlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelPlaceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
