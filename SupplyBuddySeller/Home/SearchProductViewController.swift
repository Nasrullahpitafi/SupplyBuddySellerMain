//
//  SearchProductViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 31/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class SearchProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var search : String = ""
    var productsData : AllProductsModel?

    
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableview.delegate = self
        mytableview.dataSource = self
        SearchProduct(search: search)
        mytableview.reloadData()
        // Do any additional setup after loading the view.
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
        cell.categoryLabel.text! = (productsData?.data[indexPath.row]?.category?.name) as! String
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
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
    
    
    
    
    
    func SearchProduct(search:String){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.searchProductApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","q":search], success: { response in
            let data = self.parseResponseForProducts(response: response)
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
    func parseResponseForProducts(response:Any)->AnyObject?{
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
        return nil
    }
}
