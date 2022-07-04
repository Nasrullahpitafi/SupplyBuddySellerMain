// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct InvoiceModel: Codable {
    let code: String
    let status: Int
    let msg: String
    let data: [InvoiceData]
}

// MARK: - Datum
struct InvoiceData: Codable {
    let id: Int
    let restorantID, clientName, businessName, budget: String
    let date, datumDescription, downloadable: String
    let status: StatusData
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case restorantID = "restorant_id"
        case clientName = "client_name"
        case businessName = "business_name"
        case budget, date
        case datumDescription = "description"
        case downloadable, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum StatusData: String, Codable {
    case paid = "paid"
    case unpaid = "unpaid"
}

