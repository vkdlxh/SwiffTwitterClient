//
//  ViewController.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/17.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    
    // MARK: Properties
    // テーブル表示用のデータソース
    var tweets: [Tweet] = []
    
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenName: [String] = ["abcde", "12345", "Korea", "Japan", "SwiftPractice"]
        let name: [String] = ["홍길동", "신짱구", "김철수", "김영희", "맹구"]
        let profileImageURL: [String] = ["https://beebom-redkapmedia.netdna-ssl.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg",
                                         "https://pbs.twimg.com/media/COmjW9LUkAA21g8.jpg",
                                         "https://i.imgur.com/FTBSFo7.png",
                                         "https://cdn.theatlantic.com/assets/media/img/photo/2015/11/images-from-the-2016-sony-world-pho/s01_130921474920553591/main_900.jpg?1448476701",
                                         "https://static1.squarespace.com/static/524263b4e4b0adb01903b572/t/575edefe86db433ce0efcf9b/1465835270342/",
                                         ]
        
        // ダーミデータの生成
        for _ in 0...5 {
        
            let user = User(id: "1",
                            screenName: "\(screenName.randomItem() ?? "")",
                            name: "\(name.randomItem() ?? "")",
                            profileImageURL: "\(profileImageURL.randomItem() ?? "")")
            let tweet = Tweet(id: "01", text: "Twitterを作ってみましょう。ここは本文です。", user: user)
        
            //let tweets = [tweet]
            self.tweets.append(tweet)
        }
        // tableViewのリロード
        tableView.reloadData()
    }
}

// MARK: Extensions
extension TimelineViewController: UITableViewDelegate {
    
    // セルがタップされたのを検知したときに実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: あとで
        print("セルがタップされました。")
    }
    
    // --- UITableViewDelegateはセルタップなどのユーザーイベント他にも、UITableViewの見た目や挙動に関する機能も含まれています。---
    // セルの見積もりお高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // FIXME: ここ修正必要だ！
        return 200
    }
    
    // セルの高さ指定をする処理
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


extension TimelineViewController: UITableViewDataSource {
    
    // 何個のセルを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // tweetsの配列内の要素数分を指定
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TweetTableViewCellを表示したいので、TweetTableViewCellを取得
        // dequeueReusableCellはStoryboardから指定したIdentifierのセルを取得する処理
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        
        // TweetTableViewCellの描画内容となるtweetを渡す
        cell.fill(tweet: tweets[indexPath.row])
        
        return cell
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
