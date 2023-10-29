//
//  MySpot.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import Foundation

struct MySpot {
    let emoji: String
    let name: String
    let latitude: Float
    let longitude: Float
    
    func getLatitudeLabel() -> String {
        return "緯度: \(latitude)"
    }
    
    func getLongitudeLabel() -> String {
        return "経度: \(longitude)"
    }
}
