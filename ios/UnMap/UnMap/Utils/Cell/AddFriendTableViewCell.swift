//
//  AddFriendTableViewCell.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class AddFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!

    @IBAction func followPressed(_ sender: Any) {
        
    }
    
    func setCell(_ unFriend: UnFriend) {
        Task {
            do {
                let data = try await unFriend.getUserImageData()
                let image = UIImage(data: data)
                userImage.image = image
            } catch {
                userImage.image = #imageLiteral(resourceName: "SampleUserIcon")
            }
        }
        
        userNameLabel.text = unFriend.name
        userIdLabel.text = unFriend.userId
    }
}
