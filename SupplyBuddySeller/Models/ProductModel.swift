// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductModel: Codable {
    let code: String
    let status: Int
    let msg: String
    let data: [ProductData]
}

// MARK: - Datum
struct ProductData: Codable {
    let id: Int
    let restorantID, generalCatID, name, datumDescription: String
    let price, capacity, unit, discount: String
    let stock, categoryID, createdAt, updatedAt: String
    let available, hasVariants: String
    let vat, deletedAt: String?
    let shortDescription: String
    let imagePath: [String]
    let imagesKey: [String]
    let imageIcon: [String]
    let category: Category
    let pcategory: Pcategory
    
    enum CodingKeys: String, CodingKey {
        case id
        case restorantID = "restorant_id"
        case generalCatID = "general_cat_id"
        case name
        case datumDescription = "description"
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
        case imageIcon, category, pcategory
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name, restorantID, parentID: String
    let createdAt, updatedAt: AtedAt
    let orderIndex, active: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case restorantID = "restorant_id"
        case parentID = "parent_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderIndex = "order_index"
        case active
    }
}

enum AtedAt: String, Codable {
    case the20210129T062131000000Z = "2021-01-29T06:21:31.000000Z"
    case the20210129T062132000000Z = "2021-01-29T06:21:32.000000Z"
    case the20210215T044407000000Z = "2021-02-15T04:44:07.000000Z"
}

// MARK: - Pcategory
struct Pcategory: Codable {
    let id: Int
    let name: String
    let image: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

