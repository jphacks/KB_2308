//
//  FriendLocation.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import UIKit

struct Friend {
    let imagePath: String
    let userName: String
    let userId: String
    let location: String
    let updatedAt: Date
    
    func getTimeAgo() -> String {
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince(updatedAt)
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .full
        
        if timeInterval < 0 {
            return ""
        } else if timeInterval < 60 {
            // Within 60 seconds
            dateFormatter.allowedUnits = [.second]
        } else if timeInterval < 60 * 60 {
            // Within 1 hour
            dateFormatter.allowedUnits = [.minute]
        } else {
            // Greater than 1 hour
            dateFormatter.allowedUnits = [.hour]
        }
        
        return dateFormatter.string(from: timeInterval)!
    }
    
    func getUserImageData() async throws -> Data {
        let imageUrl = URL(string: imagePath)!
        let request = URLRequest(url: imageUrl)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
