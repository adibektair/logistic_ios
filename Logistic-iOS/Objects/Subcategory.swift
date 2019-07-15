import Foundation
import ObjectMapper


class Subcategory : NSObject, NSCoding, Mappable{
    
    var productCategoryId : Int?
    var productSubcategoryId : Int?
    var subCategoryAddInfo : String?
    var subcategoryName : CategoryName?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Subcategory()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        productCategoryId <- map["productCategoryId"]
        productSubcategoryId <- map["productSubcategoryId"]
        subCategoryAddInfo <- map["subCategoryAddInfo"]
        subcategoryName <- map["subcategoryName"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        productCategoryId = aDecoder.decodeObject(forKey: "productCategoryId") as? Int
        productSubcategoryId = aDecoder.decodeObject(forKey: "productSubcategoryId") as? Int
        subCategoryAddInfo = aDecoder.decodeObject(forKey: "subCategoryAddInfo") as? String
        subcategoryName = aDecoder.decodeObject(forKey: "subcategoryName") as? CategoryName
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if productCategoryId != nil{
            aCoder.encodeConditionalObject(productCategoryId, forKey: "productCategoryId")
        }
        if productSubcategoryId != nil{
            aCoder.encodeConditionalObject(productSubcategoryId, forKey: "productSubcategoryId")
        }
        if subCategoryAddInfo != nil{
            aCoder.encodeConditionalObject(subCategoryAddInfo, forKey: "subCategoryAddInfo")
        }
        if subcategoryName != nil{
            aCoder.encode(subcategoryName, forKey: "subcategoryName")
        }
        
    }
    
}
