//
//  TSACViewController
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/8.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSACViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    fileprivate let itemDataSouce: [[(title: String, subTitle: String, iconImage: UIImage?)]] = [
            [
                ("", "", nil),
            ],
            [
                ("雷达加朋友", "添加身边的朋友", TSAsset.Add_friend_icon_reda.image),
                ("面对面建群", "与身边的朋友进入同一个群聊", TSAsset.Add_friend_icon_addgroup.image),
                ("扫一扫", "扫描二维码名片",TSAsset.Add_friend_icon_scanqr.image),
                ("手机联系人", "添加通讯录中的朋友", TSAsset.Add_friend_icon_contacts.image),
                ("公共号", "获取更多咨询和服务", TSAsset.Add_friend_icon_offical.image),
            ],
        ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加朋友"
        self.listTableView.ts_registerCellNib(TSACSearchCell.self)
        self.listTableView.ts_registerCellNib(TSACImageTextCell.self)
        self.listTableView.tableFooterView = UIView() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: @protocol - UITableViewDelegate
extension TSACViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            //TODO 这里的内容要动态的，还要加二维码
            let label = UILabel()
            label.textAlignment = NSTextAlignment.center
            label.font = label.font.withSize(CGFloat(12))
            label.text = "我的微信号：fdx19901129"
            return label
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if section == 0 {
            return 50
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: @protocol - UITableViewDataSource
extension TSACViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 45.0
        } else {
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:TSACSearchCell = tableView.ts_dequeueReusableCell(TSACSearchCell.self)
            return cell
        } else {
            let cell:TSACImageTextCell = tableView.ts_dequeueReusableCell(TSACImageTextCell.self)
            let item = self.itemDataSouce[indexPath.section][indexPath.row]
            cell.iconImageView.image = item.iconImage
            cell.titleLabel.text = item.title
            cell.subTitleLabel.text = item.subTitle
            return cell
        }
    }

}
