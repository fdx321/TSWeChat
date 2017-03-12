//
//  TSACSearchCell
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/8.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSACSearchCell: UITableViewCell {
    @IBOutlet weak var searchBar:UISearchBar?
    
    var searchResultTVC:TSACSearchResultViewController?
    var searchController:UISearchController?
    
    var readyForSearchDelegate: TSACReadyForSearch = TSACReadyForSearch()
    var beforeSearchDelegate: TSACBeforeSearch = TSACBeforeSearch()

    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar?.backgroundImage = UIImage()
        searchBar?.delegate = self
        
        //设置搜索结果页
        self.searchResultTVC = TSACSearchResultViewController.ts_initFromNib() as? TSACSearchResultViewController
        self.searchResultTVC?.tableView?.dataSource = beforeSearchDelegate
        self.searchResultTVC?.tableView?.delegate = beforeSearchDelegate
        
        self.searchController = UISearchController.init(searchResultsController: searchResultTVC)
        
        self.searchController?.searchBar.placeholder = "搜索"
        self.searchController?.searchBar.setValue("取消", forKey: "_cancelButtonText")
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchResultsController?.view.addObserver(self, forKeyPath: "hidden", options: [], context: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //为了点击搜索框的时候立即显示结果页
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let someView: UIView = object as! UIView? {
            if (someView == self.searchController?.searchResultsController?.view &&
                (keyPath == "hidden") &&
                (self.searchController?.searchResultsController?.view.isHidden)! &&
                (self.searchController?.searchBar.isFirstResponder)!) {
                self.searchController?.searchResultsController?.view.isHidden = false
            }
        }
    }
    
    deinit {
        self.searchController?.searchResultsController?.view.removeObserver(self, forKeyPath: "hidden")
    }
    
}

extension TSACSearchCell: UISearchBarDelegate {
    //点击搜索框的时候立即显示结果页
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.yy_viewController?.present(self.searchController!, animated: true, completion: nil)
    }
}

extension TSACSearchCell: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController){
        if (searchController.searchBar.text?.length)! > 0 {
            readyForSearchDelegate.searchText = (self.searchController?.searchBar.text)!
            readyForSearchDelegate.parentViewController = self.yy_viewController!
            self.searchResultTVC?.tableView?.dataSource = readyForSearchDelegate
            self.searchResultTVC?.tableView?.delegate = readyForSearchDelegate
        }else{
            self.searchResultTVC?.tableView?.dataSource = beforeSearchDelegate
            self.searchResultTVC?.tableView?.delegate = beforeSearchDelegate
        }
        searchResultTVC?.tableView?.reloadData()
    }
}




