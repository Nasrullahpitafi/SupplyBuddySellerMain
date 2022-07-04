
import Foundation

// MARK: - Welcome
struct OrderStatusesModel: Codable {
    let code: String
    let status: Int
    let msg, recMsg: String
    let data: OrderStatusesModelData
    
    enum CodingKeys: String, CodingKey {
        case code, status, msg
        case recMsg = "rec_msg"
        case data
    }
}

// MARK: - DataClass
struct OrderStatusesModelData: Codable {
    let orderID, statusID: String
    let userID: Int
    let updatedAt, createdAt: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case statusID = "status_id"
        case userID = "user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
