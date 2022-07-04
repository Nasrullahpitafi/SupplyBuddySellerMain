//
//  PatmentsViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class PaymentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mytableview: UITableView!
    
    @IBOutlet weak var withdrawview: UIView!
    
    @IBOutlet weak var banknumberField: UITextField!
    
    @IBOutlet weak var bankaddressField: UITextField!
    
    @IBOutlet weak var shortcodeField: UITextField!
    
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var accField: UITextField!
    @IBOutlet weak var routingnoField: UITextField!
    
    @IBOutlet weak var totalinvoiceLabel: UILabel!
    
    @IBOutlet weak var paidinvoiceLabel: UILabel!
    
    @IBOutlet weak var cancelinvoiceLabel: UILabel!
    
    @IBOutlet weak var rejectedinvoiceLabel: UILabel!
    
    @IBOutlet weak var walletLabel: UILabel!
    var paymentsData : PaymentModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableview.delegate = self
        mytableview.dataSource = self
        withdrawview.isHidden = true
        design()
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        PaymentsHistory()
        withdrawview.isHidden = true

        mytableview.reloadData()
    }
    func design(){
        banknumberField.textfieldDesign()
        bankaddressField.textfieldDesign()
        shortcodeField.textfieldDesign()
        accField.textfieldDesign()
        routingnoField.textfieldDesign()
        totalinvoiceLabel.text! = String(Constants.dashDetails?.data?.total_invoice ?? 0)
        cancelinvoiceLabel.text! = String(Constants.dashDetails?.data?.cancel_invoice ?? 0)
        paidinvoiceLabel.text! = String(Constants.dashDetails?.data?.paid_invoice ?? 0)
        rejectedinvoiceLabel.text! = String(Constants.dashDetails?.data?.declined_orders ?? 0)
    }
    
    
    @IBAction func crossPressed(_ sender: UIButton) {
        withdrawview.isHidden = true

    }
    
    @IBAction func viewAllPressed(_ sender: UIButton) {
        
        let viewController:InvoiceListViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "InvoiceListViewController") as! InvoiceListViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    @IBAction func withdrawPressed(_ sender: Any) {
        WIthDraw()
    }
    
    @IBAction func requestPressed(_ sender: UIButton) {
        withdrawview.isHidden = false

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return paymentsData?.data.transactions.count ?? 0
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PaymentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentsTableViewCell
        cell.depositLabel.text! = (paymentsData?.data?.transactions[indexPath.row]?.mode).map { $0.rawValue } ?? ""
        cell.marketnameLabel.text! = paymentsData?.data?.transactions[indexPath.row]?.reciever?.marketName ?? ""
        cell.dateLabel.text! = paymentsData?.data?.transactions[indexPath.row]?.createdAt?.components(separatedBy: "T").first ?? ""
        let status = paymentsData?.data?.transactions[indexPath.row]?.status ?? ""
        
        if status == "completed"{
        cell.statusLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else if status == "pending"
        {
            cell.statusLabel.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        }
        cell.statusLabel.text! = status
        cell.priceLabel.text! = paymentsData?.data?.transactions[indexPath.row]?.amount ?? ""
        
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
        return 125
    }
    func WIthDraw(){
        SVProgressHUD.show()
      //  iGjrrTFtUzL86cxGLkkCo0o17VHirehjjUB5bmI8pXqz7LIEuYFhlJdcYrgs1dBU0xLjDGVbeGxxFW0x
        RemoteRequest.requestPostURL(Constants.WithDrawApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","bank_name":banknumberField.text!,"bank_address":bankaddressField.text!,"account_no":accField.text!,"short_code":shortcodeField.text!,"routing_no":routingnoField.text!,"amount":amountField.text!], success: { response in
            let data = self.parseResponseForPayments(response: response)
            if  let sellers = data as? AddProductModel {
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
    func PaymentsHistory(){
        SVProgressHUD.show()
   //     api token = iGjrrTFtUzL86cxGLkkCo0o17VHirehjjUB5bmI8pXqz7LIEuYFhlJdcYrgs1dBU0xLjDGVbeGxxFW0x
        let apiToken = (Constants.user?.data.apiToken ?? "")
        RemoteRequest.requestGetURL(Constants.PaymentHistoryApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForPayments(response: response)
            if  let sellers = data as? PaymentModel {
                self.paymentsData = sellers
                self.mytableview.reloadData()
                print("Success Data")
                print(self.paymentsData?.data?.wallet ?? "")
                self.walletLabel.text! = self.paymentsData?.data?.wallet ?? ""
                SVProgressHUD.dismiss()
                
            } else{
                print("error")
                SVProgressHUD.dismiss()
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    func parseResponseForPayments(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(PaymentModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
    func parseResponseForWithdraw(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(AddProductModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
