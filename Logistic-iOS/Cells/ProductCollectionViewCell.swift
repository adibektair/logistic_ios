//
//  ProductCollectionViewCell.swift
//  Logistic-iOS
//
//  Created by User on 6/19/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import SDWebImage
class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var product: Product?
    
    public func setView(product: Product){
        self.product = product
        self.initView()
    }
    func initView(){
        self.layer.cornerRadius = 9
        if let image = product?.photoUrlsList{
            let fullNameArr = image.components(separatedBy: ",")
            var name = ""
            if fullNameArr.count == 0{
                name = image
            }else{
                name = fullNameArr[0]
            }
            self.imageView.sd_setImage(with: URL(string:  "http://87.255.197.72:8080/product/uploads/" + name), placeholderImage: #imageLiteral(resourceName: "map"))
            
        }else{
            imageView.image = #imageLiteral(resourceName: "map")
        }
        self.priceLabel.text = "\(product!.price!) тг"
        if let name = product?.productNameEn{
            self.nameLabel.text = name
        }else if let name = product?.productNameRu{
            self.nameLabel.text = name
        }else{
            self.nameLabel.text = ""

        }
        
    }
    
}
