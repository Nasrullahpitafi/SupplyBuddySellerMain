
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AddProductModel: Codable {
    let code: String
    let status: Int
    let msg: String
    let data: AddProductModelData
}

// MARK: - DataClass
struct AddProductModelData: Codable {
    let restorantID: Int
    let generalCatID, categoryID, name, dataDescription: String
    let price, capacity, unit, discount: String
    let stock, available, updatedAt, createdAt: String
    let id: Int
    let shortDescription: String
    let imagePath: [String]
    let imagesKey: [String]
    let imageIcon: [String]
    
    enum CodingKeys: String, CodingKey {
        case restorantID = "restorant_id"
        case generalCatID = "general_cat_id"
        case categoryID = "category_id"
        case name
        case dataDescription = "description"
        case price, capacity, unit, discount, stock, available
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case shortDescription = "short_description"
        case imagePath
        case imagesKey = "images_key"
        case imageIcon
    }
}
