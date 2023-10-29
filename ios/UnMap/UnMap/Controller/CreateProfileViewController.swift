//
//  CreateProfileViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var userIdTextField: CustomTextField!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var userIdErrorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectImagePressed(_ sender: UIButton) {
    }
    @IBAction func savePressed(_ sender: Any) {
    }
}
