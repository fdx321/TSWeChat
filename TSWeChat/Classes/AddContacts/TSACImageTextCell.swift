//
//  TSACImageTextCell
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/8.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSACImageTextCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

