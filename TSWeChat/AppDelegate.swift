//
//  AppDelegate.swift
//  TSWeChat
//
//  Created by Hilen on 1/8/16.
//  Copyright © 2016 Hilen. All rights reserved.
//

/*
 Free file download: http://download.wavetlan.com/SVV/Media/HTTP/http-index.htm

 */

import UIKit
import Hyphenate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, EMClientDelegate {
    var window: UIWindow?
    var tabbarController: TSTabbarViewController?
    var loginViewController:TSLoginViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.tabbarController = TSTabbarViewController()
        self.initEM()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.backgroundColor = UIColor.white

        TSApplicationManager.applicationConfigInit(emClientDelegate: self)
        
        if !EMClient.shared().options.isAutoLogin {
            self.loginViewController = TSLoginViewController.ts_initFromNib() as? TSLoginViewController
            self.loginViewController?.mainTabBarController = self.tabbarController!
            let navigationController = UINavigationController(rootViewController: loginViewController!)
            self.window!.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
        }
        
        return true
    }

    func autoLoginDidCompleteWithError(_ aError: EMError){
        if aError != nil {
            //自动登录失败，进入登录页面
            UIAlertController.ts_singleButtonAlertWithTitle("",message:"进入登录页面",completion:nil)
        } else {
            //自动登录成功，进入主页面
            self.window!.rootViewController = self.tabbarController
            self.window!.makeKeyAndVisible()
        }
    }
    
    //MARK: 初始化环信
    func initEM(){
        let options = EMOptions.init(appkey:"1168170303178521#fdxwechat")
        let error = EMClient.shared().initializeSDK(with: options)
        if error != nil {
            UIAlertController.ts_singleButtonAlertWithTitle("",message:"初始化环信失败",completion:{() -> Void in
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            })
        }
        
        EMClient.shared().add(self, delegateQueue: nil)
    }
}





