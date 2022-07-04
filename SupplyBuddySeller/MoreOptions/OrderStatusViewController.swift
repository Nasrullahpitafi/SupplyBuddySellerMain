//
//  OrderStatusViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class OrderStatusViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mytableview: UITableView!
    var orderdata : OrderListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableview.delegate = self
        mytableview.dataSource = self
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetOrderList()
        mytableview.reloadData()
    }
    
    @IBAction func removePressed(_ sender: UIButton) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderdata?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderStatusesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderStatusesTableViewCell
        cell.dateLabel.text! =  orderdata?.data[indexPath.row].createdAt.components(separatedBy: "T").first ?? ""
        cell.statusLabel.text! = orderdata?.data[indexPath.row].name ?? ""
        
        
        if orderdata?.data[indexPath.row].name ?? "" == "Order Recieved"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        else if orderdata?.data[indexPath.row].name ?? "" == "Preparing"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        else if orderdata?.data[indexPath.row].name ?? "" == "On the way"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        }
        else if orderdata?.data[indexPath.row].name ?? "" == "Delivered"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        else if orderdata?.data[indexPath.row].name ?? "" == "Completed"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
    func GetOrderList(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.GetOrderListApiUrl, params: [:], success: { response in
            let data = self.parseResponseForOrderStatuses(response: response)
            if  let sellers = data as? OrderListModel {
                print("Success Data")
                self.orderdata = sellers
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
    func parseResponseForOrderStatuses(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(OrderListModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
