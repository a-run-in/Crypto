//
//  CTHomeListingDataModel.swift
//  Crypto
//
//  Created by Arun on 16/10/24.
//

struct CTHomeListingDataModel: Codable {
    let name: String
    let symbol: String
    let isNew: Bool
    let isActive: Bool
    let type: AssetType
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }
    
    enum AssetType: String, Codable {
        case coin = "coin"
        case token = "token"
    }
}

extension CTHomeListingDataModel{
    
    static var cacheKey:String{
        "CTHomeListingDataModelCache"
    }
    
}

