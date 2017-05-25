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
        
        self.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.layoutMargins = UIEdgeInsets.zero
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
