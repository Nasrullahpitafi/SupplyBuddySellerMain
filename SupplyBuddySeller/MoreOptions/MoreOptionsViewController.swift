//
//  MoreOptionsViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class MoreOptionsViewController: UIViewController {

    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var marketnameLabel: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusBtn: UIButton!
    
    @IBOutlet weak var groupsBtn: UIButton!
    
    @IBOutlet weak var paymentsBtn: UIButton!
    
    @IBOutlet weak var profileView: UIView!
    
    
    var loginData : Login?
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
      

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "More Options"

        nameLabel.text!  =  Constants.user?.data.firstName ?? ""
        marketnameLabel.text! =  Constants.user?.data.marketName ?? ""
        emailLabel.text! =  Constants.user?.data.email ?? ""
        print(loginData?.data.firstName ?? "")
        profileImage()
        setprofileimage()
        navigationBarButton()
        
        
        profileView.backgroundColor = .white
        profileView.layer.cornerRadius = 8
        profileView.layer.shadowColor = UIColor.gray.cgColor
        profileView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        profileView.layer.shadowRadius = 6.0
        profileView.layer.shadowOpacity = 0.3
        profileView.layer.masksToBounds = true
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
    
    
    func profileImage(){
        if let url = URL(string: Constants.user?.data.imageurl ?? "") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { /// execute on main thread
                    self.profileimage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    func setprofileimage(){
        
        profileimage.layer.borderWidth = 1
        profileimage.layer.masksToBounds = false
        profileimage.layer.borderColor = UIColor.black.cgColor
        profileimage.layer.cornerRadius = profileimage.frame.height/2
        profileimage.clipsToBounds = true
    }

    @IBAction func editPressed(_ sender: UIButton) {
        let viewController:EditProfileViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func paymentPressed(_ sender: UIButton) {
        print("payment pressed")
        let viewController:PaymentsViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "PaymentsViewController") as! PaymentsViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func optiongroupsPressed(_ sender: UIButton) {
        print("option pressed")


    }
    
    @IBAction func orderstatusPressed(_ sender: UIButton) {
          print("order pressed")
        let viewController:OrderStatusViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "OrderStatusViewController") as! OrderStatusViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func GetProfile(){
        SVProgressHUD.show()
        RemoteRequest.requestGetURL(Constants.GetProfileApiUrl, params: ["api_token":Constants.user?.data.apiToken ?? ""], success: { response in
            let data = self.parseResponseForLogin(response: response)
            if  let sellers = data as? Login {
                self.loginData = sellers
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
    func parseResponseForLogin(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(Login?.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
