// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct OrdersModel: Codable {
    let code: String?
    let status: Int?
    let msg: String?
    let data: [Datum?]
}

// MARK: - Datum
struct Datum: Codable {
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
    let client: Client?
    let status: [Status?]
    
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
        case client, status
    }
}

// MARK: - Client
struct Client: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let apiToken: String?
    let image: String?
    let imageurl, iconurl, thumbnailurl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case apiToken = "api_token"
        case image, imageurl, iconurl, thumbnailurl
    }
}

// MARK: - Status
struct Status: Codable {
    let id: Int?
    let name, alias, active, createdAt: String?
    let updatedAt: String?
    let pivot: Pivot?
    
    enum CodingKeys: String, CodingKey {
        case id, name, alias, active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }
}

// MARK: - Pivot
struct Pivot: Codable {
    let orderID, statusID, userID, createdAt: String?
    let comment: String?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case statusID = "status_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case comment
    }
}

