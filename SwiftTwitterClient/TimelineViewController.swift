//
//  ViewController.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/17.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // テーブル表示用のデータソース
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        LoginCommunicator().login() { isSuccess in
            switch isSuccess {
            case false:
                print("ログイン失敗")
            case true:
                print("ログイン成功")
                
            TwitterCommunicator().getTimeline() { [weak self] data, error in
                
                if let error = error {
                    print(error)
                    return
                }
                
                print(data)
                let timelineParset = TimelineParser()
                let tweets = timelineParset.parse(data: data!)
                
                print(tweets)
                
                self?.tweets = tweets
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                }
            }
        }
    }
}


extension TimelineViewController: UITableViewDelegate {
    
    // セルがタップされたのを検知したときに実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされました。")
    }
    
    // --- UITableViewDelegateはセルタップなどのユーザーイベント他にも、UITableViewの見た目や挙動に関する機能も含まれています。---
    // セルの見積もりお高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
