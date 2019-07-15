//
//  ImageCell.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var imgView: UIImageView!{
        didSet{
            self.imgView.layer.cornerRadius = self.imgView.frame.height * 0.4
            self.imageView?.layer.masksToBounds = false
        }
    }
    
    
    
}
