//
//  CreateMySpotViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class CreateMySpotViewController: UIViewController {

    @IBOutlet weak var emojiTextField: CustomTextField!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var latitudeTextField: CustomTextField!
    @IBOutlet weak var longitudeTextField: CustomTextField!
    
    @IBOutlet weak var emojiErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var longitudeErrorLabel: UILabel!
    @IBOutlet weak var latitudeErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func popUpPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func savePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
