//
//  MySpotViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class MySpotViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mySpots = [
        MySpot(emoji: "🏠", name: "家", latitude: 2423.2342341, longitude: 135.3242433412),
        MySpot(emoji: "🏫", name: "大学", latitude: 2423.2342341, longitude: 135.3242433412)
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySpots.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySpotTableViewCell", for: indexPath) as! MySpotTableViewCell
        
        cell.setCell(mySpots[indexPath.section])
        
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
    
    @IBAction func addPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToAddMySpot", sender: self)
    }
    
    @IBAction func popUpPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
}
