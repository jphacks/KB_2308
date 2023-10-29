//
//  DeleteAccountButton.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

class DeleteAccountButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customDesign()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customDesign()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customDesign()
    }
    
    private func customDesign() {
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        backgroundColor = UIColor(named: "baseColor")
        setTitleColor(UIColor.red, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
    }
}
