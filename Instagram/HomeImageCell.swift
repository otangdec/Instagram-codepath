//
//  imageCell.swift
//  Instagram
//
//  Created by Oranuch on 3/6/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit

class HomeImageCell: UITableViewCell {

    @IBOutlet weak var creationTimeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLabel.text = "TEST TEST"
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
