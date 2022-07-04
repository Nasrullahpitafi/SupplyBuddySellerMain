//
//  OrderStatusesListViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 23/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import iOSDropDown
import SVProgressHUD
class OrderStatusesListViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var mytableview: UITableView!
    
    @IBOutlet weak var statusField: DropDown!
    
    var orderid : Int = 0
    var orderdata : OrderListModel?
    var orderDetail : OrderStatusDetailModel?

    var list = ["Order Recieved","Preparing","Ready","On the way","Delivered","Completed"]


    override func viewDidLoad() {
        super.viewDidLoad()
        mytableview.delegate = self
        mytableview.dataSource = self
        
        setUpDropDown()
        
        
        
        print(orderid)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        GetOrderList()
        mytableview.reloadData()
    }
    
    func setUpDropDown()
    {
        statusField.text! = list[0]
        statusField.textfieldDesign()
        statusField.optionArray = list
        statusField.selectedRowColor = .gray
        self.statusField.didSelect { (selectedText, index, id) in
            print("\(selectedText)\(index)\(id)")
            if selectedText == "Order Recieved"{
                self.PostOrderStatus(id: 1)
                
                self.GetOrderList()
                self.mytableview.reloadData()
            }
            else if selectedText == "Preparing"{
                self.PostOrderStatus(id: 2)
                
                
                self.GetOrderList()
                self.mytableview.reloadData()
            }
            else if selectedText == "Ready"{
                self.PostOrderStatus(id: 3)
                
                
                self.GetOrderList()
                self.mytableview.reloadData()
                
            }
            else if selectedText == "On the way"{
                self.PostOrderStatus(id: 4)
                
                
                self.GetOrderList()
                self.mytableview.reloadData()
                
            }
            else if selectedText == "Delivered"{
                self.PostOrderStatus(id: 5)
               
                
                self.GetOrderList()
                self.mytableview.reloadData()
                
                
            }
            else if selectedText == "Completed"{
                self.PostOrderStatus(id: 6)
                
                
                self.GetOrderList()
                self.mytableview.reloadData()
               
            }
            
            
        }
        
        
   
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetail?.data.count ?? 0
    }
    
    @IBAction func removePressed(_ sender: UIButton) {
        DeleteOrderStatus(id:Int(orderDetail?.data[sender.tag]?.statusID ?? "") ?? 0)
        mytableview.reloadData()


    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderStatusesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderStatusesTableViewCell
        cell.dateLabel.text! =   (orderDetail?.data[indexPath.row]?.title?.createdAt).map { $0.rawValue }?.components(separatedBy: "T").first ?? ""
        cell.statusLabel.text! = orderDetail?.data[indexPath.row]?.title?.name ?? ""
        
        if orderDetail?.data[indexPath.row]?.title?.name ?? "" == "Order Recieved"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        else if orderDetail?.data[indexPath.row]?.title?.name ?? "" == "Preparing"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        else if orderDetail?.data[indexPath.row]?.title?.name ?? "" == "On the way"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
        else if orderDetail?.data[indexPath.row]?.title?.name ?? "" == "Delivered"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        else if orderDetail?.data[indexPath.row]?.title?.name ?? "" == "Completed"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DeleteOrderStatus(id:Int(orderDetail?.data[indexPath.row]?.statusID ?? "") ?? 0)

        if editingStyle == UITableViewCell.EditingStyle.delete {
            orderDetail?.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
  
    func GetOrderList(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.orderstatusDetailAPiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":String(orderid)], success: { response in
            let data = self.parseResponseForPostOrderStatuses(response: response)
            if  let sellers = data as? OrderStatusDetailModel {
                print("Success Data")
                self.orderDetail = sellers
                self.mytableview.reloadData()
                SVProgressHUD.dismiss()
                
            } else{
                print("error")
                SVProgressHUD.dismiss()
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    
    func DeleteOrderStatus(id:Int){
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.removeOrderStatusApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":String(orderid),"status_id":String(id)], success: { response in
           
            let dic = response as? NSDictionary
            let message = dic?["msg"] as? String
            let code = dic?["code"] as? String
            print(message ?? "")
            print(code ?? "")
            if code == "200"
            {
           //     self.mytableview.reloadData()
            }
            SVProgressHUD.dismiss()

            
        }) { error in
        }
    }
    func PostOrderStatus(id:Int){
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.CretaeOrderStatusApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","order_id":String(orderid),"status_id":String(id)], success: { response in
            let data = self.parseResponseForPostOrderStatuses(response: response)
            if  let sellers = data as? OrderStatusDetailModel {
                print("Success Data")
                self.alertAction(message: sellers.msg ?? "" )

                
                self.orderDetail = sellers
                self.mytableview.reloadData()
                SVProgressHUD.dismiss()
                
            } else{
                print("error")
                SVProgressHUD.dismiss()
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    func parseResponseForPostOrderStatuses(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(OrderStatusDetailModel.self, from: jsonData!)
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
