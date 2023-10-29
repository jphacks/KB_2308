//
//  FriendLocationTableViewCell.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/28.
//

import UIKit

class FriendLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(friendLocation: Friend) {
        Task {
            do {
                let data = try await friendLocation.getUserImageData()
                let image = UIImage(data: data)
                userImage.image = image
            } catch {
                userImage.image = #imageLiteral(resourceName: "SampleUserIcon")
            }
        }
        
        userNameLabel.text = friendLocation.userName
        userIdLabel.text = friendLocation.userId
        timeAgoLabel.text = friendLocation.getTimeAgo()
        locationLabel.text = friendLocation.location
    }

}
