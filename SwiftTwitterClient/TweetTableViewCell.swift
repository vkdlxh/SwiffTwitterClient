//
//  TweetTableViewCell.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/18.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    // アイコンを表示するUIImageView
    @IBOutlet weak var iconImageView: UIImageView!
    // 名前(전상준)を表示するUILabel
    @IBOutlet weak var nameLabel: UILabel!
    // スクリーンネーム(@tkdwnszoq)を表示するUILabel
    @IBOutlet weak var screenNameLabel: UILabel!
    // ツイートの本文を表示するUILabel
    @IBOutlet weak var textContentLabel: UILabel!
    
    func fill(tweet: Tweet) {
        //profileImageURLから画像をダウンロードしてくる処理
        let downloadTask = URLSession.shared.dataTask(with: URL(string: tweet.user.profileImageURL)!) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self?.iconImageView.image = UIImage(data: data!)
            }
        }
        downloadTask.resume()
        
        //tweetから値を取り出して、UIをセットする
        nameLabel.text = tweet.user.name
        textContentLabel.text = tweet.text
        //screenNameには "@"が含まれていないので、頭に "@"を入れてあげる必要がある
        screenNameLabel.text = "@" + tweet.user.screenName
    }
}
