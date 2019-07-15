//
//  Product.swift
//  Logistic-iOS
//
//  Created by User on 6/18/19.
//  Copyright © 2019 User. All rights reserved.
//

//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class Product : NSObject, NSCoding, Mappable{
    
    var manufacturer : String?
    var photoUrlsList : String?
    var price : Int?
    var productCategoryId : Int?
    var productDescription : String?
    var productId : Int?
    var productNameEn : String?
    var productNameKk : String?
    var productNameRu : String?
    var productSubcategoryId : Int?
    var sellerCompanyId : Int?
    var serialNumber : String?
    var size : String?
    var specialCharacteristicsId : Int?
    var uniqueIdNumber : String?
    var weight : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Product()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        manufacturer <- map["manufacturer"]
        photoUrlsList <- map["photoUrlsList"]
        price <- map["price"]
        productCategoryId <- map["productCategoryId"]
        productDescription <- map["productDescription"]
        productId <- map["productId"]
        productNameEn <- map["productNameEn"]
        productNameKk <- map["productNameKk"]
        productNameRu <- map["productNameRu"]
        productSubcategoryId <- map["productSubcategoryId"]
        sellerCompanyId <- map["sellerCompanyId"]
        serialNumber <- map["serialNumber"]
        size <- map["size"]
        specialCharacteristicsId <- map["specialCharacteristicsId"]
        uniqueIdNumber <- map["uniqueIdNumber"]
        weight <- map["weight"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as? String
        photoUrlsList = aDecoder.decodeObject(forKey: "photoUrlsList") as? String
        price = aDecoder.decodeObject(forKey: "price") as? Int
        productCategoryId = aDecoder.decodeObject(forKey: "productCategoryId") as? Int
        productDescription = aDecoder.decodeObject(forKey: "productDescription") as? String
        productId = aDecoder.decodeObject(forKey: "productId") as? Int
        productNameEn = aDecoder.decodeObject(forKey: "productNameEn") as? String
        productNameKk = aDecoder.decodeObject(forKey: "productNameKk") as? String
        productNameRu = aDecoder.decodeObject(forKey: "productNameRu") as? String
        productSubcategoryId = aDecoder.decodeObject(forKey: "productSubcategoryId") as? Int
        sellerCompanyId = aDecoder.decodeObject(forKey: "sellerCompanyId") as? Int
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as? String
        size = aDecoder.decodeObject(forKey: "size") as? String
        specialCharacteristicsId = aDecoder.decodeObject(forKey: "specialCharacteristicsId") as? Int
        uniqueIdNumber = aDecoder.decodeObject(forKey: "uniqueIdNumber") as? String
        weight = aDecoder.decodeObject(forKey: "weight") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if manufacturer != nil{
            aCoder.encodeConditionalObject(manufacturer, forKey: "manufacturer")
        }
        if photoUrlsList != nil{
            aCoder.encodeConditionalObject(photoUrlsList, forKey: "photoUrlsList")
        }
        if price != nil{
            aCoder.encodeConditionalObject(price, forKey: "price")
        }
        if productCategoryId != nil{
            aCoder.encodeConditionalObject(productCategoryId, forKey: "productCategoryId")
        }
        if productDescription != nil{
            aCoder.encodeConditionalObject(productDescription, forKey: "productDescription")
        }
        if productId != nil{
            aCoder.encodeConditionalObject(productId, forKey: "productId")
        }
        if productNameEn != nil{
            aCoder.encodeConditionalObject(productNameEn, forKey: "productNameEn")
        }
        if productNameKk != nil{
            aCoder.encodeConditionalObject(productNameKk, forKey: "productNameKk")
        }
        if productNameRu != nil{
            aCoder.encodeConditionalObject(productNameRu, forKey: "productNameRu")
        }
        if productSubcategoryId != nil{
            aCoder.encodeConditionalObject(productSubcategoryId, forKey: "productSubcategoryId")
        }
        if sellerCompanyId != nil{
            aCoder.encodeConditionalObject(sellerCompanyId, forKey: "sellerCompanyId")
        }
        if serialNumber != nil{
            aCoder.encodeConditionalObject(serialNumber, forKey: "serialNumber")
        }
        if size != nil{
            aCoder.encodeConditionalObject(size, forKey: "size")
        }
        if specialCharacteristicsId != nil{
            aCoder.encodeConditionalObject(specialCharacteristicsId, forKey: "specialCharacteristicsId")
        }
        if uniqueIdNumber != nil{
            aCoder.encodeConditionalObject(uniqueIdNumber, forKey: "uniqueIdNumber")
        }
        if weight != nil{
            aCoder.encodeConditionalObject(weight, forKey: "weight")
        }
        
    }
    
}
