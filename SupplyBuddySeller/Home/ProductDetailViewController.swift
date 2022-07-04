//
//  ProductDetailViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 27/01/2022.
//  Copyright © 2022 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
import iOSDropDown
class ProductDetailViewController: UIViewController {

    
    @IBOutlet weak var productDetailBtn: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    
    @IBOutlet weak var userinfoBtn: UIButton!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var clientnameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var buildingnumberLabel: UILabel!
    
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var deliveryType: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var deliveryDate: UILabel!
    
    @IBOutlet weak var invoiceTableview: UITableView!
    
    
    
    @IBOutlet weak var dispatchView: UIView!
    @IBOutlet weak var acceptOrderBtn: UIButton!
    @IBOutlet weak var backtoOrderBtn: UIButton!
    
    
    @IBOutlet weak var declineView: UIView!
    @IBOutlet weak var reasonField: DropDown!
    @IBOutlet weak var RejectOrderBtn: UIButton!
    @IBOutlet weak var backToOrderBtn: UIButton!
    
    @IBOutlet weak var dispatchBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    
    var productdetail : ProductDetailModel?
    var orderid : Int = 0
    var user : Bool = true
    var reasonArray = ["Choose a reason here","Items not available","Out of stock","Some techinal issue occurs","Sorry we got closed"]
    var reason : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductDetail()
        
        invoiceTableview.delegate = self
        invoiceTableview.dataSource = self

        productTableView.delegate = self
        productTableView.dataSource = self
        
  
        dispatchView.isHidden = true
        declineView.isHidden = true
        
      
        
        setUpView()

    }
    
    @IBAction func dispatchPressed(_ sender: UIButton) {
        dispatchView.isHidden = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        

    }
    
    @IBAction func acceptOrderPressed(_ sender: UIButton) {
        RemoteRequest.requestPostURL(Constants.acceptOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":orderid], success: { response in
            
            let dic = response as? NSDictionary
            let message = dic?["msg"] as? String
            let code = dic?["code"] as? String
            
            print(message ?? "")
            print(code ?? "")
            if code == "200"
            {
                let viewController:HomeViewController = UIStoryboard(name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               // viewController.modalPresentationStyle = .fullScreen
                viewController.hidesBottomBarWhenPushed = false
                
                self.navigationController?.popViewController(animated: true)


            }
            
        }) { error in
            SVProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func backtoOrderPressed(_ sender: UIButton) {
        dispatchView.isHidden = true
    }
    @IBAction func declinePressed(_ sender: UIButton) {
        declineView.isHidden = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)

        reasonField.optionArray = reasonArray
        reasonField.text! = reasonArray[0]
        self.reasonField.selectedRowColor = .gray
     
        self.reasonField.didSelect { (selectedText, index, id) in
            print("\(selectedText)\(index)\(id)")
            self.reason = selectedText
        }
        }
        
    
    
    @IBAction func rejectOrderPressed(_ sender: UIButton) {
        RemoteRequest.requestPostURL(Constants.declineOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":orderid,"reason":reason], success: { response in
            
            let dic = response as? NSDictionary
            let message = dic?["msg"] as? String
            let code = dic?["code"] as? String
            
            print(message ?? "")
            print(code ?? "")
            if code == "200"
            {
                let viewController:HomeViewController = UIStoryboard(name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
              //  viewController.modalPresentationStyle = .fullScreen
                viewController.hidesBottomBarWhenPushed = false
                self.navigationController?.popViewController(animated: true)
              //  self.navigationController?.pushViewController(viewController, animated: true)

                
            }
            
        }) { error in
            SVProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func backToOrderRejectPressed(_ sender: UIButton) {
        declineView.isHidden = true
    }
    func setUpView(){
        backToOrderBtn.setTitle("BACK TO ORDER", for: .normal)
        backToOrderBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        backToOrderBtn.layer.borderWidth = 1
        backToOrderBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        backToOrderBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        backtoOrderBtn.setTitle("BACK TO ORDER", for: .normal)
        backtoOrderBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        backtoOrderBtn.layer.borderWidth = 1
        backtoOrderBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        backtoOrderBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        reasonField.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        reasonField.clipsToBounds = true
        reasonField.borderWidth = 1
    }
    func ProductDetail(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.productDetailApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":orderid], success: { response in
            let data = self.parseResponseForProductDetail(response: response)
            if  let sellers = data as? ProductDetailModel {
                self.productdetail = sellers
                
                self.clientnameLabel.text! = self.productdetail?.data?.client?.firstName ?? ""
                self.cityLabel.text! = self.productdetail?.data?.address?.city ?? ""
                self.zipcodeLabel.text! = self.productdetail?.data?.address?.zipcode ?? ""
                self.countryLabel.text! = self.productdetail?.data?.address?.country ?? ""
                self.buildingnumberLabel.text! = self.productdetail?.data?.address?.address ?? ""
                self.deliveryDate.text! = self.productdetail?.data?.deliveryDay ?? ""
                self.deliveryTime.text! = self.productdetail?.data?.deliveryPickupInterval ?? ""
                
                self.productTableView.reloadData()
                self.invoiceTableview.reloadData()
                
                print("Success Data")
                
                
                SVProgressHUD.dismiss()
                
            } else{
                print("error")
                SVProgressHUD.dismiss()
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    
    func parseResponseForProductDetail(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(ProductDetailModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
}
extension ProductDetailViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productTableView
        {
            return productdetail?.data?.orderItems.count ?? 0

        }
       else  if tableView == invoiceTableview
        {
            return productdetail?.data?.orderItems.count ?? 0

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == productTableView
        {
            let cell:ProductDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductDetailTableViewCell
            
            cell.nameLabel.text! = productdetail?.data?.orderItems[indexPath.row]?.name ?? ""
            cell.priceLabel.text! = productdetail?.data?.orderItems[indexPath.row]?.price ?? ""
            cell.categoryLabel.text! = productdetail?.data?.orderItems[indexPath.row]?.category?.name ?? ""
            
            if let url = URL(string: productdetail?.data?.orderItems[indexPath.row]?.imagePath[0] ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async { /// execute on main thread
                        cell.productImage.image = UIImage(data: data)
                        cell.productImage.layer.cornerRadius = 12
                        
                    }
                }
                task.resume()
            }
            
            
            return cell
        }
       else  if tableView == invoiceTableview
        {
            
            let cell:ProductDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductDetailTableViewCell
            
            cell.nameLabel.text! = productdetail?.data?.orderItems[indexPath.row]?.name ?? ""
            cell.priceLabel.text! = productdetail?.data?.orderItems[indexPath.row]?.price ?? ""
            
            return cell
            
        }
        
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == productTableView
        {
            return 75

        }
      else   if tableView == invoiceTableview
        {
            return 40
        }
        return 0
    }
    
    
}
