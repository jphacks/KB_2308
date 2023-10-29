//
//  EditMySpotViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class EditMySpotViewController: UIViewController {

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
    @IBAction func savePressed(_ sender: UIButton) {
    }
    @IBAction func popUpPressed(_ sender: UIButton) {
    }
}
