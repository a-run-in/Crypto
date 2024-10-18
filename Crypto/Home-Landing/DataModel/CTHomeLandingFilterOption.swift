//
//  CTHomeLandingFilterOption.swift
//  Crypto
//
//  Created by Arun on 18/10/24.
//

enum CTHomeLandingFilterOption: CaseIterable{
    case active
    case inactive
    case tokens
    case coins
    case new
    
    init?(identifier:String){
        switch identifier{
        case "active":
            self = .active
        case "inactive":
            self = .inactive
        case "tokens":
            self = .tokens
        case "coins":
            self = .coins
        case "new":
            self = .new
        default:
            return nil
        }
    }
    
    var displayName: String{
        switch self {
        case .active:
            "Active"
        case .inactive:
            "Inactive"
        case .tokens:
            "Tokens"
        case .coins:
            "Coins"
        case .new:
            "New"
        }
    }
    
    var identifier: String{
        switch self {
        case .active:
            "active"
        case .inactive:
            "inactive"
        case .tokens:
            "tokens"
        case .coins:
            "coins"
        case .new:
            "new"
        }
    }
}
