//
//  LoginCommunicator.swift
//  SwiftTwitterClient
//
//  Created by jeon sangjun on 2017/10/18.
//  Copyright © 2017年 jeon sangjun. All rights reserved.
//

import Social
import Accounts

struct LoginCommunicator {
    
    // クロージャが関数のスコープ外で保持される可能性のためにescaping
    func login(handler: @escaping (Bool) -> ()) {
        // Twitterが利用可能かどうかを確認する
        if !SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            handler(false)
            return
        }
        
        // 端末内のアカウントストアを参照
        let store = ACAccountStore()
        let type = store.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        //Twitterのアカウント情報へのアクセスをリクエスト
        store.requestAccessToAccounts(with: type, options: nil) { granted, error in
            
            // 承認されなかった場合
            guard granted else {
                handler(false)
                return
            }
            
            // 何らかのエラーがあった場合
            if let _ = error {
                handler(false)
                return
            }
            
            let accounts = store.accounts(with: type)
            
            // 複数あるであろうアカウントの中から最初の一つを取得
            if let account = accounts?.first as? ACAccount {
                // staticなtwitterAccountに保持
                Account.twitterAccount = account
                handler(false)
            }
        }
    }
}
