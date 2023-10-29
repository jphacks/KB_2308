//
//  FriendRequestViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class FriendRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let unFriends = [
        UnFriend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", name: "中西直", userId: "nanaonanika", isRequesting: false, isPendign: false, isFollow: false),
        UnFriend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", name: "中西直", userId: "nanaonanika", isRequesting: false, isPendign: false, isFollow: false)
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return unFriends.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestTableCell", for: indexPath) as! FriendRequestTableViewCell
        
        cell.setCell(unFriends[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func popUpPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
