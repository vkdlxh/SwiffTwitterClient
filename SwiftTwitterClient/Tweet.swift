//
//  Tweet.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/18.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import Foundation

struct Tweet {
    
    // TweetのID
    let id: String
    
    // Tweetの本文
    let text: String
    
    // このTweetの主
    let user: User
    
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }
        
        guard let id = dictionary["id_str"] as? String else { return nil}
        guard let text = dictionary["text"] as? String else { return nil}
        guard let userJSON = dictionary["user"] else { return nil}
        guard let user = User(json: userJSON) else { return nil}
        
        self.id = id
        self.text = text
        self.user = user
    }
}
