//
//  CountryTableViewCell.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 10.04.17.
//
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
