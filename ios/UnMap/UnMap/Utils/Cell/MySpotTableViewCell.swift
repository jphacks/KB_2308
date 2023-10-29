//
//  MySpotTableViewCell.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class MySpotTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBAction func deletePressed(_ sender: UIButton) {
    }
    @IBAction func editPressed(_ sender: UIButton) {
    }
    
    func setCell(_ mySpot: MySpot) {
        emojiLabel.text = mySpot.emoji
        nameLabel.text = mySpot.name
        latitudeLabel.text = mySpot.getLatitudeLabel()
        longitudeLabel.text = mySpot.getLongitudeLabel()
    }
}
