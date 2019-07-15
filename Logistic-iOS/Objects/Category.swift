//
//  Category.swift
//  Logistic-iOS
//
//  Created by User on 6/19/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import ObjectMapper

class Category : NSObject, NSCoding, Mappable{

    @objc func encode(with aCoder: NSCoder)
    {
        if addInfo != nil{
            aCoder.encodeConditionalObject(addInfo, forKey: "addInfo")
        }
        if categoryName != nil{
            aCoder.encode(categoryName, forKey: "categoryName")
        }
        if productCategoryId != nil{
            aCoder.encodeConditionalObject(productCategoryId, forKey: "productCategoryId")
        }
        
    }
    
    var addInfo : String?
    var categoryName : CategoryName?
    var productCategoryId : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Category()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        addInfo <- map["addInfo"]
        categoryName <- map["categoryName"]
        productCategoryId <- map["productCategoryId"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addInfo = aDecoder.decodeObject(forKey: "addInfo") as? String
        categoryName = aDecoder.decodeObject(forKey: "categoryName") as? CategoryName
        productCategoryId = aDecoder.decodeObject(forKey: "productCategoryId") as? Int
        
    }
    

}


class CategoryName : NSObject, NSCoding, Mappable{
    
    var en : String?
    var kk : String?
    var ru : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CategoryName()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        en <- map["en"]
        kk <- map["kk"]
        ru <- map["ru"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        en = aDecoder.decodeObject(forKey: "en") as? String
        kk = aDecoder.decodeObject(forKey: "kk") as? String
        ru = aDecoder.decodeObject(forKey: "ru") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if en != nil{
            aCoder.encodeConditionalObject(en, forKey: "en")
        }
        if kk != nil{
            aCoder.encodeConditionalObject(kk, forKey: "kk")
        }
        if ru != nil{
            aCoder.encodeConditionalObject(ru, forKey: "ru")
        }
        
    }
    
}
