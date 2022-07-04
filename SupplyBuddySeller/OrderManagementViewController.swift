//
//  OrderManagementViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class OrderManagementViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var ordertableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    var OrdersData : OrdersModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        ordertableview.delegate = self
        ordertableview.dataSource = self
      //  initializeHideKeyboard()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Order Management"

        pendingOrder()
       ordertableview.reloadData()
        navigationBarButton()
    //    self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationBarButton()
        self.tabBarController?.navigationItem.title = "Order Management"

    }
    func navigationBarButton(){
        
        let buttonWidth = CGFloat(40)
        let buttonHeight = CGFloat(40)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "notification"), for: .normal)
        button.addTarget(self, action: #selector(self.NotificationTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        
        
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "chat"), for: .normal)
        button2.addTarget(self, action: #selector(self.ChatTapped), for: .touchUpInside)
        button2.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button2.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button2)
    }
    @objc func ChatTapped(){
        let viewController:ChatViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func NotificationTapped(){
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segment.selectedSegmentIndex {
        case 0:
            return OrdersData?.data.count ?? 0
        case 1:
            return OrdersData?.data.count ?? 0
        case 2:
            return OrdersData?.data.count ?? 0
            
        default:
            break;
        }
        return 0
    }
    
    @IBAction func detailPressed(_ sender: UIButton) {
        print (OrdersData?.data[sender.tag]?.id ?? 0 )
        print(OrdersData?.data[sender.tag]?.orderStatus ?? "")
        if OrdersData?.data[sender.tag]?.orderStatus == "accepted"{
            let viewController:OrderStatusesListViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "OrderStatusesListViewController") as! OrderStatusesListViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.orderid = OrdersData?.data[sender.tag]?.id ?? 0
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else if OrdersData?.data[sender.tag]?.orderStatus == "completed"{
            print("completed")
            alertAction(message: "Can't Change Status of Previous Order")
        }
        else if OrdersData?.data[sender.tag]?.orderStatus == "declined"{
            print("completed")
            alertAction(message: "Can't Change Status of Previous Order")
        }
        else if OrdersData?.data[sender.tag]?.orderStatus ?? "" == "pending"
        {
            print (OrdersData?.data[sender.tag]?.id ?? 0)
            let viewController:ProductDetailViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.orderid = OrdersData?.data[sender.tag]?.id ?? 0
            self.navigationController?.pushViewController(viewController, animated: true)
        }


    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : OrdersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrdersTableViewCell
        switch segment.selectedSegmentIndex {
        case 0:
            cell.nameLabel.text! = OrdersData?.data[indexPath.row]?.client?.firstName ?? ""
            cell.priceLabel.text! = OrdersData?.data[indexPath.row]?.orderPrice ?? ""
            cell.statusLabel.text! = OrdersData?.data[indexPath.row]?.orderStatus ?? ""
            cell.nextBtn.tag = indexPath.row
            
            if let url = URL(string: OrdersData?.data[indexPath.row]?.client?.imageurl ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async { /// execute on main thread
                        cell.orderimage.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
            let icon = UIImage(named: "pending")
            cell.icon.image = icon
            
            if OrdersData?.data[indexPath.row]?.orderStatus == "pending"
            {
                let image = UIImage(named: "tick")
                cell.nextBtn.setImage(image, for: .normal)
            }
            else if OrdersData?.data[indexPath.row]?.orderStatus == "accepted"
            {
                let image = UIImage(named: "detail")
                cell.nextBtn.setImage(image, for: .normal)
            }
            return cell
            
         case 1:
            cell.nameLabel.text! = OrdersData?.data[indexPath.row]?.client?.firstName ?? ""
            cell.priceLabel.text! = OrdersData?.data[indexPath.row]?.orderPrice ?? ""
            cell.statusLabel.text! = OrdersData?.data[indexPath.row]?.orderStatus ?? ""
            
            if let url = URL(string: OrdersData?.data[indexPath.row]?.client?.imageurl ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async { /// execute on main thread
                        cell.orderimage.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
            
            let icon = UIImage(named: "completed")
            cell.icon.image = icon
            
             if OrdersData?.data[indexPath.row]?.orderStatus == "completed"
            {
                let image = UIImage(named: "detail")
                cell.nextBtn.setImage(image, for: .normal)
            }
            return cell
            
        case 2:
            cell.nameLabel.text! = OrdersData?.data[indexPath.row]?.client?.firstName ?? ""
            cell.priceLabel.text! = OrdersData?.data[indexPath.row]?.orderPrice ?? ""
            cell.statusLabel.text! = OrdersData?.data[indexPath.row]?.orderStatus ?? ""
        //    cell.detailBtn.tag = indexPath.row
            
            if let url = URL(string: OrdersData?.data[indexPath.row]?.client?.imageurl ?? "") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async { /// execute on main thread
                        cell.orderimage.image = UIImage(data: data)
                    }
                }
                task.resume()
            }
            
            let icon = UIImage(named: "rejected")
            cell.icon.image = icon
            
            if OrdersData?.data[indexPath.row]?.orderStatus == "declined"
            {
                let image = UIImage(named: "detail")
                cell.nextBtn.setImage(image, for: .normal)
            }
            return cell
            
        default:
            break;
            
        }
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.3
        
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func segemetPressed(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            pendingOrder()
            ordertableview.reloadData()
        }
        else if segment.selectedSegmentIndex == 1{
            CompletedOrder()
            ordertableview.reloadData()
        }
        else if segment.selectedSegmentIndex == 2{
            RejectedOrder()
            ordertableview.reloadData()
        }
    }
    
    func RejectedOrder(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.DeclinedOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForOrders(response: response)
            if  let sellers = data as? OrdersModel {
                
                self.OrdersData = sellers
                self.ordertableview.reloadData()
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
    
    
    func CompletedOrder(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.CompletedOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForOrders(response: response)
            if  let sellers = data as? OrdersModel {
                
                self.OrdersData = sellers
                self.ordertableview.reloadData()
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
    func pendingOrder(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.PendingOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForOrders(response: response)
            if  let sellers = data as? OrdersModel {
                
                self.OrdersData = sellers
                self.ordertableview.reloadData()
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
   
    
    func parseResponseForOrders(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(OrdersModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
    func alertAction(message : String){
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
}
