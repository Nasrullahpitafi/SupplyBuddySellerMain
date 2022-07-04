//
//  ProductDetailsViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 23/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var decLabel: UILabel!
    
    @IBOutlet weak var soldLabel: UILabel!
    
    @IBOutlet weak var inStockLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var capacityLabel: UILabel!
    
    @IBOutlet weak var myimageView: UIImageView!
    
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var deactivateSwitc: UISwitch!
    var productId : Int = 0
    var imagePath = [String]()
    var descriptiom : String = ""
    var price : String = ""
    var category : String = ""
    var sold : String = ""
    var inStock : String = ""
    var discount : String = ""
    var capacity : String = ""
    var name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(productId)
        nameLabel.text! = name
        priceLabel.text! = price
     //   decLabel.text! = descriptiom
        categoryLabel.text! = category
        soldLabel.text! = sold
        inStockLabel.text! = inStock
        discountLabel.text! = discount
        capacityLabel.text! = capacity
        if let url = URL(string: imagePath[0] ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    self.myimageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationBarButton()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func switch1Pressed(_ sender: UISwitch) {
        if deactivateSwitc.isOn{
            
        }
        else{
            
        }
    }
    
    @IBAction func switch2Pressed(_ sender: UISwitch) {
        if switch2.isOn{
            
        }
        else{
            
        }
    }
    func navigationBarButton(){
        
        let buttonWidth = CGFloat(40)
        let buttonHeight = CGFloat(40)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)

        
    }
    @objc func buttonTapped(){
        
        let viewController:AddNewProductViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "AddNewProductViewController") as! AddNewProductViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}
