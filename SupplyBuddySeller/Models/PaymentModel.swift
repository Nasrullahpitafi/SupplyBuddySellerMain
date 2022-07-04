// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct PaymentModel: Codable {
    let code: String?
    let status: Int?
    let msg: String?
    let data: PaymentModelData?
}

// MARK: - DataClass
struct PaymentModelData: Codable {
    let transactions: [Transaction?]
    let wallet: String?
}

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int?
    let userID, recieverID, amount: String?
    let currency: String?
    let type: TypeEnum?
    let status: String?
    let mode: Mode?
    let createdAt, updatedAt: String?
    let sender, reciever: Reciever?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case recieverID = "reciever_id"
        case amount, currency, type, status, mode
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case sender, reciever
    }
}


enum Mode: String, Codable {
    case deposit = "deposit"
    case withdraw = "withdraw"
}

// MARK: - Reciever
struct Reciever: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let marketName: String?
    let apiToken: String?
    let imageurl, iconurl, thumbnailurl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case marketName = "market_name"
        case apiToken = "api_token"
        case imageurl, iconurl, thumbnailurl
    }
}



enum TypeEnum: String, Codable {
    case orderPayment = "Order Payment"
    case withdrawRequest = "withdraw request"
}



