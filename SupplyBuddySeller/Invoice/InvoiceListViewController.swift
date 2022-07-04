//
//  InvoiceListViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class InvoiceListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 

    @IBOutlet weak var mytableview: UITableView!
    var invoicedata : InvoiceModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        mytableview.delegate = self
        mytableview.dataSource = self
        initializeHideKeyboard()


    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Invoice List"

        InvoiceList()
        mytableview.reloadData()
        navigationBarButton()
    }
    func navigationBarButton(){
        
        let buttonWidth = CGFloat(40)
        let buttonHeight = CGFloat(40)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "chat"), for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        
        
        
        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "notification"), for: .normal)
        button2.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button2.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button2.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: button2)
    }
    @objc func buttonTapped(){
        print("invoice button click")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoicedata?.data.count ?? 0
    }
    
    @IBAction func addInvoiceListPressed(_ sender: UIButton) {
        print("order pressed")
        let viewController:AddInvoiceListViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "AddInvoiceListViewController") as! AddInvoiceListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : InvoiceListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvoiceListTableViewCell
        
        cell.nameLabel.text! = invoicedata?.data[indexPath.row].clientName ?? ""
        cell.idLabel.text! = String(invoicedata?.data[indexPath.row].id ?? 0)
        cell.budgetLabel.text! = invoicedata?.data[indexPath.row].budget ?? ""
        cell.dateLabel.text! = invoicedata?.data[indexPath.row].date ?? ""
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.3
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func InvoiceList(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.InvoiceListAPiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForInvoice(response: response)
            if  let sellers = data as? InvoiceModel {
                self.invoicedata = sellers
                self.mytableview.reloadData()
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
    
    
    func parseResponseForInvoice(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(InvoiceModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
