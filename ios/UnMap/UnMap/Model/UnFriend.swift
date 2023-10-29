//
//  UnFriend.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import Foundation

struct UnFriend {
    let imagePath: String
    let name: String
    let userId: String
    
    let isRequesting: Bool
    let isPendign: Bool
    let isFollow: Bool

    func getCanFollow() -> Bool {
        return !isRequesting && !isPendign
    }
    
    func getCanAcceptFollowRequest() -> Bool {
        return isPendign
    }
    
    func getCanDeclineFollowReqest() -> Bool {
        return isPendign
    }
    
    func follow() {
        print("Follow")
    }
    
    func acceptFollowRequest() {
        print("accept follow request")
    }
    
    func declineFollowRequest() {
        
    }
    
    func getUserImageData() async throws -> Data {
        let imageUrl = URL(string: imagePath)!
        let request = URLRequest(url: imageUrl)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
