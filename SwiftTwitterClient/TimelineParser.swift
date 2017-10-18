//
//  TimelineParser.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/18.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import Foundation

// 取得したjsonはシリアライズして、データモデルに変換する必要がある
struct TimelineParser {
    func parse(data: Data) -> [Tweet] {
        let serializedData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        let json = serializedData as! [Any]
        
        let timeline: [Tweet] = json.flatMap {
            Tweet(json: $0)
        }
        
        return timeline
    }
}

