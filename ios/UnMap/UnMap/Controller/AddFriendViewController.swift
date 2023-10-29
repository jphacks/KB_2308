//
//  AddFriendViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let unFriends = [
        UnFriend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", name: "中西直", userId: "nanaonanika", isRequesting: false, isPendign: false, isFollow: false)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendTableCell", for: indexPath) as! AddFriendTableViewCell
        
        cell.setCell(unFriends[indexPath.row])
        print("Return cellはできてるよ！")
        
        return cell
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let marginView = UIView()
//        marginView.backgroundColor = .clear
//        return marginView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return .leastNonzeroMagnitude
//    }
    
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var searchTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func inputSearchEnded(_ sender: CustomTextField) {
    }
}
