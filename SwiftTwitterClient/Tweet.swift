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
}
