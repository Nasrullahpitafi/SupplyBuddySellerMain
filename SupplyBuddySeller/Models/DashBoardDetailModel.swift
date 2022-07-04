// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DashdetailModel: Codable {
    let code: String?
    let status: Int?
    let msg: String?
    let data: DashdetailModelData?
}

// MARK: - DataClass
struct DashdetailModelData: Codable {
    let total_sales, new_orders, pending_orders, declined_orders: Int?
    let total_stock: String?
    let total_invoice, paid_invoice, cancel_invoice: Int?
    
}

