//
//  User.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/18.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import Foundation

struct User {
    
    // ユーザーのID
    let id: String
    
    // (@)tkdwnszoq
    let screenName: String
    
    // 전상준
    let name: String
    
    // プロフィール画像URL
    let profileImageURL: String
    
    // データモデルにjson用のinitを作る
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }
        
        guard let id = dictionary["id_str"] as? String else { return nil}
        guard let screenName = dictionary["screen_name"] as? String else { return nil}
        guard let name = dictionary["name"] as? String else { return nil}
        guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil}
        
        self.id = id
        self.screenName = screenName
        self.name = name
        self.profileImageURL = profileImageURL
    }
}
