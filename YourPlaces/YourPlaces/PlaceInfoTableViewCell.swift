//
//  PlaceInfoTableViewCell.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 25.05.17.
//
//

import UIKit

class PlaceInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var labelKey: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
