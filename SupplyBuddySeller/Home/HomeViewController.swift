//
//  HomeViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var ordertableview: UITableView!
    
    @IBOutlet weak var viewallOrdersBtn: UIButton!
    
    @IBOutlet weak var neworderLabel: UILabel!
    
    @IBOutlet weak var totalStocksLabel: UILabel!
    
    @IBOutlet weak var newOrderLabel: UILabel!
    
    @IBOutlet weak var pendingOrderLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var pendingView: UIView!
    
    var pendingData : OrdersModel?
    var dashboardDetail : DashdetailModel?
    let cellSpacingHeight: CGFloat = 5
    var isSearch : Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        ordertableview.delegate = self
        ordertableview.dataSource = self
        DashBoardDetail()
        searchBar.delegate = self
        


        setUpView()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Home"

        pendingOrder()
        navigationBarButton()
        ordertableview.reloadData()
    }
    func setUpView()
    {
        
        stockView.backgroundColor = .white
        stockView.layer.cornerRadius = 12
        stockView.layer.borderColor = #colorLiteral(red: 0.4196078431, green: 0.3176470588, blue: 0.6784313725, alpha: 1)
        stockView.layer.shadowColor = UIColor.gray.cgColor
        stockView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        stockView.layer.shadowRadius = 6.0
        stockView.layer.shadowOpacity = 0.3
        stockView.layer.masksToBounds = false
        
        orderView.backgroundColor = .white
        orderView.layer.cornerRadius = 12
        orderView.layer.borderColor = #colorLiteral(red: 0.4196078431, green: 0.3176470588, blue: 0.6784313725, alpha: 1)
        orderView.layer.shadowColor = UIColor.gray.cgColor
        orderView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        orderView.layer.shadowRadius = 6.0
        orderView.layer.shadowOpacity = 0.3
        orderView.layer.masksToBounds = false
        
        pendingView.backgroundColor = .white
        pendingView.layer.cornerRadius = 12
        pendingView.layer.borderColor = #colorLiteral(red: 0.4196078431, green: 0.3176470588, blue: 0.6784313725, alpha: 1)
        pendingView.layer.shadowColor = UIColor.gray.cgColor
        pendingView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        pendingView.layer.shadowRadius = 6.0
        pendingView.layer.shadowOpacity = 0.3
        pendingView.layer.masksToBounds = false
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
    
    @IBAction func detailPressed(_ sender: UIButton) {
        
        if pendingData?.data[sender.tag]?.orderStatus ?? "" == "accepted"
        {
            print (pendingData?.data[sender.tag]?.id ?? 0)
            let viewController:OrderStatusesListViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "OrderStatusesListViewController") as! OrderStatusesListViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.orderid = pendingData?.data[sender.tag]?.id ?? 0
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else if pendingData?.data[sender.tag]?.orderStatus ?? "" == "pending"
        {
            print (pendingData?.data[sender.tag]?.id ?? 0)
            let viewController:ProductDetailViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            viewController.modalPresentationStyle = .fullScreen
            viewController.orderid = pendingData?.data[sender.tag]?.id ?? 0
            self.navigationController?.pushViewController(viewController, animated: true)
        }

    }
    
    @IBAction func addproductPressed(_ sender: UIButton) {
        
            let viewController:AddNewProductViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "AddNewProductViewController") as! AddNewProductViewController
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func viewallOrdersPressed(_ sender: UIButton) {
        let viewController:OrderManagementViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "OrderManagementViewController") as! OrderManagementViewController
         viewController.modalPresentationStyle = .fullScreen
        viewController.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingData?.data.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell : OrdersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrdersTableViewCell
        cell.nameLabel.text! = pendingData?.data[indexPath.row]?.client?.firstName ?? ""
        cell.priceLabel.text! = pendingData?.data[indexPath.row]?.orderPrice ?? ""
        cell.statusLabel.text! = pendingData?.data[indexPath.row]?.orderStatus ?? ""
        
        if pendingData?.data[indexPath.row]?.orderStatus == "pending"
        {
            let image = UIImage(named: "tick")
            cell.detailBtn.setImage(image, for: .normal)
        }
       else if pendingData?.data[indexPath.row]?.orderStatus == "accepted"
        {
            let image = UIImage(named: "detail")
            cell.detailBtn.setImage(image, for: .normal)
        }
        cell.detailBtn.tag = indexPath.row

        if let url = URL(string: pendingData?.data[indexPath.row]?.client?.imageurl ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    cell.orderimage.image = UIImage(data: data)
                }
            }
            task.resume()
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear

        return cellSpacingHeight
    }
    func pendingOrder(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.PendingOrderApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForOrders(response: response)
            if  let sellers = data as? OrdersModel {
                
                self.pendingData = sellers
                print(self.pendingData?.data.count)
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
    
    func DashBoardDetail(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.dashboardAPiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForDashBoardDetail(response: response)
            if  let sellers = data as? DashdetailModel {
                
                self.ordertableview.reloadData()
                
                
                print("Success Data")
                
                self.dashboardDetail = sellers
                Constants.dashDetails = sellers
                
                
                self.neworderLabel.text! = "8"
                self.newOrderLabel.text! = String(sellers.data?.new_orders ?? 0)
                self.totalStocksLabel.text! = sellers.data?.total_stock ?? ""
                self.pendingOrderLabel.text! = String(sellers.data?.pending_orders ?? 0)
                
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
    func parseResponseForDashBoardDetail(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(DashdetailModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
extension HomeViewController: UISearchBarDelegate{
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print(searchBar.text!)
      
        let viewController:SearchProductViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "SearchProductViewController") as! SearchProductViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.search = searchBar.text!
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
        ///    self.maintableView.reloadData()
        } else {
            
    /*        filteredTableData = tableData.filter({ (text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(filteredTableData.count == 0){
                isSearch = false
            } else {
                isSearch = true
            }
            self.maintableView.reloadData()*/
        }
    }
    
}
