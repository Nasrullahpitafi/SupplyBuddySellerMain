//
//  ProductManagementViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class ProductManagementViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mytableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var productsData : AllProductsModel?
    var productStatus : ProductStatusModel?
    var isSearch : Bool = false
    var active : String?
    override func viewDidLoad() {
        super.viewDidLoad()
     //   initializeHideKeyboard()
        searchBar.delegate = self

        AllProducts()

        mytableview.delegate = self
        mytableview.dataSource = self
        mytableview.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Product Management"

        AllProducts()
        mytableview.reloadData()
        navigationBarButton()
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
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        
    
        
        if sender.isOn {
            print("ON")
            sender.setOn(true, animated: true)

            ProductStatus(itemid: productsData?.data[sender.tag]?.id ?? 0, status: "1")
         //   mytableview.reloadData()
        //    sender.setOn(true, animated: true)
            
            print(sender.tag)
            active = "1"
            
        
            
            
        }
        else {
            
           print(sender.tag)
            sender.setOn(false, animated: true)

            ProductStatus(itemid: productsData?.data[sender.tag]?.id ?? 0, status: "0")


         //   mytableview.reloadData()
         //  sender.setOn(false, animated: true)

            active = "0"
            print ("OFF")
            
            
            
        }
        
        
        
    }
    
    @IBAction func SegmentPressed(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            AllProducts()
            mytableview.reloadData()
        }
        else if segment.selectedSegmentIndex == 1{
            ActiveProducts()
            mytableview.reloadData()
        }
    }
    
    
    @IBAction func productDetailPressed(_ sender: UIButton) {
        
        let viewController:ProductDetailsViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        viewController.productId = productsData?.data[sender.tag]?.id ?? 0
        viewController.capacity = productsData?.data[sender.tag]?.capacity ?? ""
        viewController.price = productsData?.data[sender.tag]?.price ?? ""
        viewController.category =  (productsData?.data[sender.tag]?.category?.name) as! String
        viewController.inStock =  productsData?.data[sender.tag]?.stock ?? ""
        viewController.imagePath =  productsData?.data[sender.tag]?.imagePath as! [String]
        viewController.discount =  productsData?.data[sender.tag]?.discount ?? ""
        viewController.capacity =  productsData?.data[sender.tag]?.capacity ?? ""
        viewController.name = productsData?.data[sender.tag]?.name ?? ""

        
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductManagementTableViewCell
        cell.itemnameLabel.text! = productsData?.data[indexPath.row]?.name ?? ""
        cell.priceLabel.text! = productsData?.data[indexPath.row]?.price ?? ""
        cell.categoryLabel.text! = (productsData?.data[indexPath.row]?.category?.name) as? String ?? ""
        cell.productdetaulBtn.tag = indexPath.row
        cell.switchBtn.tag = indexPath.row
        if productsData?.data[indexPath.row]?.available == "0"
        {
            cell.switchBtn.setOn(false, animated: true)
        }
        else if productsData?.data[indexPath.row]?.available == "1" {
            cell.switchBtn.setOn(true, animated: true)

        }
        
     //   cell.statusLabel.text! = productsData?.data[indexPath.row].category.name ?? ""
        
        if let url = URL(string: productsData?.data[indexPath.row]?.imagePath[0] ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    cell.itemimage.image = UIImage(data: data)
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
        return 120
    }
    
    
    func AllProducts(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.AllProductsApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForProduct(response: response)
            if  let sellers = data as? AllProductsModel {
                self.productsData = sellers
                print("Success Data")
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
    func ActiveProducts(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.ActiveProductsApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForProduct(response: response)
            if  let sellers = data as? AllProductsModel {
                self.productsData = sellers
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
    func ProductStatus(itemid: Int,status:String){
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.productStatusApiUrl, params: ["api_token":"Lc1rHQPPl8qCCNaOnyUx8J5krpZjuBJZwqUkyzpXGwhflwu9oQqkI3nNLOVr9ITQdTO4mZ1xrlJQWgUp","item_id":itemid,"status":status], success: { response in
            let data = self.parseResponseForProductStatus(response: response)
            if  let sellers = data as? ProductStatusModel {
                
                
            //    self.mytableview.reloadData()
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
    func parseResponseForProductStatus(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(ProductStatusModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
    
    func parseResponseForProduct(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(AllProductsModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
    }
}
extension ProductManagementViewController: UISearchBarDelegate{
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
