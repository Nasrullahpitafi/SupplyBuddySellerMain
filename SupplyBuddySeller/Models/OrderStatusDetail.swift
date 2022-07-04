// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct OrderStatusDetailModel: Codable {
    var code: String?
    var status: Int?
    var msg: String?
    var data: [OrderStatusDetailModelData?]
}

// MARK: - Datum
struct OrderStatusDetailModelData: Codable {
    var id: Int?
    var orderID, statusID, userID, comment: String?
    var createdAt, updatedAt: String?
    var title: TitleData?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case statusID = "status_id"
        case userID = "user_id"
        case comment
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case title
    }
}

// MARK: - Title
struct TitleData: Codable {
    var id: Int?
    var name, alias, active: String?
    var createdAt: CreatedAtData?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, alias, active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum CreatedAtData: String, Codable {
    case the20210523T231020000000Z = "2021-05-23T23:10:20.000000Z"
    case the20210524T002258000000Z = "2021-05-24T00:22:58.000000Z"
}

