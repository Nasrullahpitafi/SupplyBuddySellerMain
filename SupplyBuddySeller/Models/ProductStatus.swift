// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductStatusModel: Codable {
    let code: String
    let status: Int
    let msg: String
    let data: ProductStatusModelData
}

// MARK: - DataClass
struct ProductStatusModelData: Codable {
    let id: Int
    let restorantID, generalCatID, name, dataDescription: String
    let price, capacity, unit, discount: String
    let stock, categoryID, createdAt, updatedAt: String
    let available, hasVariants: String
    let vat, deletedAt: String?
    let shortDescription: String
    let imagePath: [String]
    let imagesKey: [String]
    let imageIcon: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case restorantID = "restorant_id"
        case generalCatID = "general_cat_id"
        case name
        case dataDescription = "description"
        case price, capacity, unit, discount, stock
        case categoryID = "category_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case available
        case hasVariants = "has_variants"
        case vat
        case deletedAt = "deleted_at"
        case shortDescription = "short_description"
        case imagePath
        case imagesKey = "images_key"
        case imageIcon
    }
}



