import Foundation

// MARK: - Welcome
struct Login: Codable {
    let code, message: String?
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let googleID, fbID: String?
    let firstName: String?
    let lastName: String?
    let marketName, country, city, email: String?
    let emailVerifiedAt: String?
    let apiToken: String?
    let deviceToken: String?
    let phone: String?
    let bankName, accountTitle, accountNumber, iban: String?
    let tradeLicense, licenseExpiry, paypalEmail, commission: String?
    let createdAt, updatedAt, active: String?
    let stripeID, cardBrand, cardLastFour, trialEndsAt: String?
    let verificationCode, phoneVerifiedAt, planID: String?
    let planStatus, cancelURL, updateURL, checkoutID: String?
    let subscriptionPlanID, stripeAccount, birthDate: String?
    let lat, lng: String?
    let working: String?
    let onorder: String?
    let numorders, rejectedorders: String?
    let paypalSubscribtionID, mollieCustomerID, mollieMandateID: String?
    let taxPercentage: String?
    let extraBillingInformation, mollieSubscribtionID, paystackSubscribtionID, paystackTransID: String?
    let otp, image, role, chatID: String?
    let status, staticFee, fee, wallet: String?
    let loginSource: String?
    let imageurl, iconurl, thumbnailurl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case googleID = "google_id"
        case fbID = "fb_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case marketName = "market_name"
        case country, city, email
        case emailVerifiedAt = "email_verified_at"
        case apiToken = "api_token"
        case deviceToken = "device_token"
        case phone
        case bankName = "bank_name"
        case accountTitle = "account_title"
        case accountNumber = "account_number"
        case iban
        case tradeLicense = "trade_license"
        case licenseExpiry = "license_expiry"
        case paypalEmail = "paypal_email"
        case commission
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case active
        case stripeID = "stripe_id"
        case cardBrand = "card_brand"
        case cardLastFour = "card_last_four"
        case trialEndsAt = "trial_ends_at"
        case verificationCode = "verification_code"
        case phoneVerifiedAt = "phone_verified_at"
        case planID = "plan_id"
        case planStatus = "plan_status"
        case cancelURL = "cancel_url"
        case updateURL = "update_url"
        case checkoutID = "checkout_id"
        case subscriptionPlanID = "subscription_plan_id"
        case stripeAccount = "stripe_account"
        case birthDate = "birth_date"
        case lat, lng, working, onorder, numorders, rejectedorders
        case paypalSubscribtionID = "paypal_subscribtion_id"
        case mollieCustomerID = "mollie_customer_id"
        case mollieMandateID = "mollie_mandate_id"
        case taxPercentage = "tax_percentage"
        case extraBillingInformation = "extra_billing_information"
        case mollieSubscribtionID = "mollie_subscribtion_id"
        case paystackSubscribtionID = "paystack_subscribtion_id"
        case paystackTransID = "paystack_trans_id"
        case otp, image, role
        case chatID = "chat_id"
        case status
        case staticFee = "static_fee"
        case fee, wallet
        case loginSource = "login_source"
        case imageurl, iconurl, thumbnailurl
    }
}

