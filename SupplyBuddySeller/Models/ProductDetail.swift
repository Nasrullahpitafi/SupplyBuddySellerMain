// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProductDetailModel: Codable {
    let code: String?
    let status: Int?
    let msg: String?
    let data: ProductDetailModelData?
}

// MARK: - DataClass
struct ProductDetailModelData: Codable {
    let id: Int?
    let createdAt, updatedAt, addressID, clientID: String?
    let restorantID: String?
    let driverID: String?
    let deliveryPrice, tax, subtotal, orderPrice: String?
    let paymentMethod, paymentStatus, comment, orderStatus: String?
    let reason, lat, lng, srtipePaymentID: String?
    let fee, feeValue, staticFee, deliveryMethod: String?
    let deliveryPickupInterval, deliveryDay, vatvalue, paymentProcessorFee: String?
    let timeToPrepare, tableID, phone, whatsappAddress: String?
    let paymentLink: String?
    let reorder: String?
    let transactionID: String?
    let totalQuatity, currentTotal: Int?
    let client: ClientDetail?
    let address: AddressDetail?
    let orderItems: [OrderItem?]
    let status: [String?]
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case addressID = "address_id"
        case clientID = "client_id"
        case restorantID = "restorant_id"
        case driverID = "driver_id"
        case deliveryPrice = "delivery_price"
        case tax, subtotal
        case orderPrice = "order_price"
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case comment
        case orderStatus = "order_status"
        case reason, lat, lng
        case srtipePaymentID = "srtipe_payment_id"
        case fee
        case feeValue = "fee_value"
        case staticFee = "static_fee"
        case deliveryMethod = "delivery_method"
        case deliveryPickupInterval = "delivery_pickup_interval"
        case deliveryDay = "delivery_day"
        case vatvalue
        case paymentProcessorFee = "payment_processor_fee"
        case timeToPrepare = "time_to_prepare"
        case tableID = "table_id"
        case phone
        case whatsappAddress = "whatsapp_address"
        case paymentLink = "payment_link"
        case reorder
        case transactionID = "transaction_id"
        case totalQuatity = "total_quatity"
        case currentTotal = "current_total"
        case client, address
        case orderItems = "order_items"
        case status
    }
}

// MARK: - Address
struct AddressDetail: Codable {
    let id: Int?
    let address, country, city, state: String?
    let zipcode, createdAt, updatedAt: String?
    let lat, lng: String?
    let active, userID: String
    let apartment, intercom, floor, entry: String?
    let type, businessName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, address, country, city, state, zipcode
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lat, lng, active
        case userID = "user_id"
        case apartment, intercom, floor, entry, type
        case businessName = "business_name"
    }
}

// MARK: - Client
struct ClientDetail: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let marketName, apiToken: String?
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

// MARK: - OrderItem
struct OrderItem: Codable {
    let id: Int?
    let createdAt, updatedAt, orderID, itemID: String?
    let qty, price, discount, extras: String?
    let vat, vatvalue, variantPrice, variantName: String?
    let name, currentPrice, unit: String?
    let imagePath: [String?]
    let pcategory: PcategoryDetail?
    let category: CategoryDetail?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case orderID = "order_id"
        case itemID = "item_id"
        case qty, price, discount, extras, vat, vatvalue
        case variantPrice = "variant_price"
        case variantName = "variant_name"
        case name
        case currentPrice = "current_price"
        case unit, imagePath, pcategory, category
    }
}

// MARK: - Category
struct CategoryDetail: Codable {
    let id: Int
    let name, restorantID, parentID, createdAt: String?
    let updatedAt, orderIndex, active: String?
    
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
struct PcategoryDetail: Codable {
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

