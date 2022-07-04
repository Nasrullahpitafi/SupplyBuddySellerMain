// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct OrderListModel: Codable {
    let code: String
    let status: Int
    let msg: String
    let data: [OrderListModelData]
}

// MARK: - Datum
struct OrderListModelData: Codable {
    let id: Int
    let name, alias, active, createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, alias, active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

