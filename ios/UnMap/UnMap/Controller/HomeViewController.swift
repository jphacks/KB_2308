//
//  ViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/28.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let friendLocations = [
        Friend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", userName: "中西直人", userId: "nanaonanika", location: "西宮市上ヶ原", updatedAt: Date().addingTimeInterval(-450)),
        Friend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", userName: "中西直", userId: "nanaonanika", location: "西宮市上ヶ原", updatedAt: Date().addingTimeInterval(-450))
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendLocations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendLocationTableCell", for: indexPath) as! FriendLocationTableViewCell
        
        cell.setCell(friendLocation: friendLocations[indexPath.row])
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "この友達を削除") { (action, view, completionHandler) in
            print("Deleteがタップされた")
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToAddFriendPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAddFriend", sender: self)
    }
}
