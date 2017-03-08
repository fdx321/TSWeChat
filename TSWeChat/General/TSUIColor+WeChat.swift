//
//  UICollor+WeChat.swift
//  TSWeChat
//
//  Created by Hilen on 11/6/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

/*
*   颜色扩展，项目内所用到的颜色，在这里进行配置
*/

import Foundation
import UIKit

extension UIColor {
    class var barTintColor: UIColor {
        get {return UIColor.init(ts_hexString: "#1A1A1A")}
    }
    
    class var tabbarSelectedTextColor: UIColor {
        get {return UIColor.init(ts_hexString: "#68BB1E")}
    }
    
    class var viewBackgroundColor: UIColor {
        get {return UIColor.init(ts_hexString: "#E7EBEE")}
    }
    
    //注册、登录按钮Enable颜色
    class var buttonEnableColor:UIColor{
        get {return UIColor.init(ts_hexString:"00B64F", alpha:1.0)}
    }
    //注册、登录按钮Disable颜色
    class var buttonDisableColor:UIColor{
        get {return UIColor.init(ts_hexString: "#00C64F", alpha:0.6)}
    }
    
    
}
