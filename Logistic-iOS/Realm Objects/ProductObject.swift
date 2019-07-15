//
//  ProductObject.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ProductObject: Object {
    @objc dynamic var name: String?
    
    @objc dynamic var price = 0
    
    @objc dynamic var desc = ""
    

    
}
