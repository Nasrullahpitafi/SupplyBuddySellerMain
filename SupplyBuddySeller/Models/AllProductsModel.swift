// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AllProductsModel: Codable {
    let code: String?
    let status: Int?
    let msg: String?
    let data: [AllProductModelData?]
}

// MARK: - Datum
struct AllProductModelData: Codable {
    let id: Int?
    let restorantID, generalCatID, name, datumDescription: String?
    let price, capacity, unit, discount: String?
    let stock, categoryID, createdAt, updatedAt: String?
    let available, hasVariants: String?
    let vat, deletedAt: String?
    let shortDescription: String?
    let imagePath: [String?]
    let imagesKey: [String?]
    let imageIcon: [String?]
    let category: CategoryData?
    let pcategory: PcategoryData?

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
struct CategoryData: Codable {
    let id: Int?
    let name, restorantID, parentID: String?
    let createdAt, updatedAt: String?
    let orderIndex, active: String?

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



// MARK: - Pcategory
struct PcategoryData: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



