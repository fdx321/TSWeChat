//
//  TSMessageViewController.swift
//  TSWeChat
//
//  Created by Hilen on 11/5/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class TSMessageViewController: UIViewController {
    @IBOutlet fileprivate weak var listTableView: UITableView!
    fileprivate var itemDataSouce = [MessageModel]()
    var actionFloatView: TSMessageActionFloatView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "微信"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.navigationItem.rightButtonAction(TSAsset.Barbuttonicon_add.image) { (Void) -> Void in
            self.actionFloatView.hide(!self.actionFloatView.isHidden)
        }
        
        //Init ActionFloatView
        self.actionFloatView = TSMessageActionFloatView()
        self.actionFloatView.delegate = self
        self.view.addSubview(self.actionFloatView)
        self.actionFloatView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsMake(64, 0, 0, 0))
        }
        
        //Init listTableView
        self.listTableView.ts_registerCellNib(TSMessageTableViewCell.self)
        self.listTableView.estimatedRowHeight = 65
        self.listTableView.tableFooterView = UIView()
        
        self.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.actionFloatView.hide(true)
    }
    
    fileprivate func fetchData() {
        guard let JSONData = Data.ts_dataFromJSONFile("message") else { return }
        let jsonObject = JSON(data: JSONData)
        if jsonObject != JSON.null {
            var list = [MessageModel]()
            for dict in jsonObject["data"].arrayObject! {
                guard let model = TSMapper<MessageModel>().map(JSON: dict as! [String : Any]) else { continue }
                list.insert(model, at: list.count)
            }
            //Insert more data, make the UITableView long and long.  XD
            self.itemDataSouce.insert(contentsOf: list, at: 0)
            self.itemDataSouce.insert(contentsOf: list, at: 0)
            self.itemDataSouce.insert(contentsOf: list, at: 0)
            self.itemDataSouce.insert(contentsOf: list, at: 0)
            self.listTableView.reloadData()
        }
    }
    
    deinit {
        log.verbose("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - @protocol UITableViewDelegate
extension TSMessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = TSChatViewController.ts_initFromNib() as! TSChatViewController
        viewController.messageModel = self.itemDataSouce[indexPath.row]
        self.ts_pushAndHideTabbar(viewController)
        
        self.itemDataSouce[indexPath.row].isRead = true
        self.listTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
}

// MARK: - @protocol UITableViewDataSource
extension TSMessageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TSMessageTableViewCell = tableView.ts_dequeueReusableCell(TSMessageTableViewCell.self)
        cell.setCellContnet(self.itemDataSouce[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView:UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //删除聊天记录
        let deleteAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "删除", handler: {(action, IndexPath) -> Void in
            self.itemDataSouce.remove(at: indexPath.row)
            //TODO，删除远程服务器上的聊天记录
            self.listTableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        //标记为已读或未读
        let isReadAction = UITableViewRowAction(style:UITableViewRowActionStyle.normal, title:"", handler:{(action, indexPath) -> Void in
            self.itemDataSouce.get(index: indexPath.row).isRead = !self.itemDataSouce.get(index: indexPath.row).isRead!
            self.listTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        })
        if self.itemDataSouce.get(index: indexPath.row).isRead! {
            isReadAction.title = "标记为未读"
        }else{
            isReadAction.title = "标记为已读"
        }
        
        //取消关注
        let unSubscribeAction = UITableViewRowAction(style:UITableViewRowActionStyle.normal, title:"取消关注", handler:{(action, indexPath) -> Void in
            //TODO 取消关注的逻辑
            self.listTableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        })

        
        let messageFromtype = self.itemDataSouce.get(index: indexPath.row).messageFromType
        if messageFromtype == MessageFromType.Personal || messageFromtype == MessageFromType.Group {
            return [deleteAction, isReadAction]
        } else if messageFromtype == MessageFromType.PublicServer || messageFromtype == MessageFromType.PublicSubscribe{
            return [deleteAction, unSubscribeAction]
        }
        
        return [deleteAction]
    }
}

// MARK: - @protocol ActionFloatViewDelegate
extension TSMessageViewController: ActionFloatViewDelegate {
    func floatViewTapItemIndex(_ type: ActionFloatViewItemType) {
        log.info("floatViewTapItemIndex:\(type)")
        switch type {
        case .groupChat:
            break
        case .addFriend:
            self.ts_pushAndHideTabbar(TSACViewController.ts_initFromNib())
            break
        case .scan:
            break
        case .payment:
            break
        }
    }
}

