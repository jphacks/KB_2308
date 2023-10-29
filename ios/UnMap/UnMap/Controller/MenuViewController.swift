//
//  MenuViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPos = self.menuView.layer.position
        self.menuView.layer.position.x = -self.menuView.frame.width
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
            },
            completion: { bool in
            })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }
    
    @IBAction func goToMySpotPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMySpot", sender: self)
    }
    @IBAction func goToFriendRequestPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToFriendRequest", sender: self)
    }
    @IBAction func goToEditProfilePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToEditProfile", sender: self)
    }
    
    @IBAction func deleteAccountPressed(_ sender: UIButton) {
    }
    @IBAction func logoutPressed(_ sender: UIButton) {
    }
    
    
}
