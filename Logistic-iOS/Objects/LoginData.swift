//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class LoginData : NSObject, NSCoding, Mappable{
    
    var customerId : Int?
    var loginId : Int?
    var password : String?
    var roleId : Int?
    var sellerCompanyId : Int?
    var shipperId : Int?
    var username : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginData()
    }
    private override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        customerId <- map["customerId"]
        loginId <- map["loginId"]
        password <- map["password"]
        roleId <- map["roleId"]
        sellerCompanyId <- map["sellerCompanyId"]
        shipperId <- map["shipperId"]
        username <- map["username"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        customerId = aDecoder.decodeObject(forKey: "customerId") as? Int
        loginId = aDecoder.decodeObject(forKey: "loginId") as? Int
        password = aDecoder.decodeObject(forKey: "password") as? String
        roleId = aDecoder.decodeObject(forKey: "roleId") as? Int
        sellerCompanyId = aDecoder.decodeObject(forKey: "sellerCompanyId") as? Int
        shipperId = aDecoder.decodeObject(forKey: "shipperId") as? Int
        username = aDecoder.decodeObject(forKey: "username") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if customerId != nil{
            aCoder.encodeConditionalObject(customerId, forKey: "customerId")
        }
        if loginId != nil{
            aCoder.encodeConditionalObject(loginId, forKey: "loginId")
        }
        if password != nil{
            aCoder.encodeConditionalObject(password, forKey: "password")
        }
        if roleId != nil{
            aCoder.encodeConditionalObject(roleId, forKey: "roleId")
        }
        if sellerCompanyId != nil{
            aCoder.encodeConditionalObject(sellerCompanyId, forKey: "sellerCompanyId")
        }
        if shipperId != nil{
            aCoder.encodeConditionalObject(shipperId, forKey: "shipperId")
        }
        if username != nil{
            aCoder.encodeConditionalObject(username, forKey: "username")
        }
        
    }
    
}
