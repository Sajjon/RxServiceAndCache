//
//  ViewController.swift
//  SingleRxSignal
//
//  Created by Alexander Cyon on 2017-10-28.
//  Copyright © 2017 Alexander Cyon. All rights reserved.
//

import UIKit
import RxSwift
import RxSwiftExt

class ViewController: UIViewController {
    let bag = DisposeBag()
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }
    
    func getUser() {
        print("Fetching user")
        userService.getUser(options: []).subscribe(onNext: {
            print("subscriber: Got user: `\($0)`")
        }, onError: {
            print("subscriber: Error: `\($0)`")
        }, onCompleted: {
            print("subscriber: Completed")
        }, onDisposed: {
            print("subscriber: Disposed")
        }).disposed(by: bag)
    }

    @IBAction func getPressed(_ sender: UIButton) {
        getUser()
    }
    
    @IBAction func clearCachePressed(_ sender: UIButton) {
        print("Clearing cache... before clearing, value existed: `\(userService.cache.hasValueForKey(key: cacheKeyName))`")
        userService.cache.deleteValueFor(key: cacheKeyName)
        print("Clearing cache... after clearing, value exists: `\(userService.cache.hasValueForKey(key: cacheKeyName))`")
    }
}

