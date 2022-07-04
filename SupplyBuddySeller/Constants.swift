//
//  Constants.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import Foundation
struct Constants {
    static let LoginAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/login"
    static let SignupApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/signup"
    static let PendingOrderApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/orders/pending"
    static let CompletedOrderApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/orders/completed"
    static let DeclinedOrderApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/orders/declined"
    static let AllProductsApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/allproducts"
    static let ActiveProductsApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/activeproducts"
    static let InvoiceListAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/invoice/list"
    static let AddProductAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/addproduct"
    static let GetProfileApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/profile"
    static let UpdateProfileUrl =   "https://supplybuddy.dedicatedevs.com/api/seller/update/profile"
    static let PaymentHistoryApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/payment/history"
    static let GetOrderListApiUrl = "https://supplybuddy.dedicatedevs.com/api/get/order/list"
    static let WithDrawApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/withdraw/request"
    static let CretaeOrderStatusApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/create/order/status"
    static let RemoveOrderStatusAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/remove/order/status"
    static let CreateInvoiceListApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/create/invoice"
    static let fotgotPasswordApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/forgotPassword"
    static let verifyOtpApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/verify-otp-recovery-account"
    static let updatePassAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/updatePassword"
    static let dashboardAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/dashboard/details"
    static let productStatusApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/product_status"
    static let searchProductApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/search/product"
    static let orderstatusDetailAPiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/order/status"
    static let productDetailApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/order/details"
    static let acceptOrderApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/order/accept"
    static let declineOrderApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/order/decline"
    static let removeOrderStatusApiUrl = "https://supplybuddy.dedicatedevs.com/api/seller/remove/order/status"
    static let CategoriesApiUrl = "https://supplybuddy.dedicatedevs.com/api/get/parent/categories"
    static let SubcategoryApiUrl = "https://supplybuddy.dedicatedevs.com/api/get/sub/categories?parent_id=2"
    
    static var user : Login?
    static var dashDetails : DashdetailModel?
}
