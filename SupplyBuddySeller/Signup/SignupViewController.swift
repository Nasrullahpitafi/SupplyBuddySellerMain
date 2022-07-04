//
//  SignupViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import Firebase



class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField : UITextField!
    @IBOutlet weak var marketTextField : UITextField!
    @IBOutlet weak var phonenoTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    var loginData : Login?
    
    var ref: FIRDatabaseReference!

    var currentDate = ""
    var currentTime = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        initializeHideKeyboard()



        design()
        CurrentDate()
        CurrentTime()
        print(currentTime)
        print(currentDate)
        // Do any additional setup after loading the view.
    }
    func CurrentDate(){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "dd/MMM/yyyy"
       // df.dateStyle = .medium
        let dateString = df.string(from: date)
        currentDate = dateString
        
    }
    func CurrentTime(){
        let date = Date()
        let df = DateFormatter()
        
        df.dateFormat = "HH:mm a"
        let dateString = df.string(from: date)
        currentTime = dateString
        
    }
  
 
    @IBAction func loginPressed(_ sender: UIButton) {
        let viewController:LoginViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    @IBAction func registerPressed(_ sender: Any) {
        RegisterUser()
    }
        // Save to FiresBase
    func saveToFireBase(){
        let userData = ["id": loginData?.data.apiToken ?? "" as String ,
                        "name": loginData?.data.firstName ?? "" as String,
                        "img": "default" as String,
                        "status": "online" as String,
                        "type": "seller" as String,
                        "date": currentDate as String,
                        "time": currentTime as String
        ]
        print(userData)
        self.ref.child("Users").child(loginData?.data.apiToken ?? "").setValue(userData)

    }
   
    func RegisterUser(){
        
        if firstnameTextField.text == "" {
            alertAction(message: "Enter your First Name")
        }
        else if lastnameTextField.text == "" {
            alertAction(message: "Enter your Last Name")
        }
        
        else if marketTextField.text == "" {
            alertAction(message: "Enter Market Name")
        }
        
        else if phonenoTextField.text == "" {
            alertAction(message: "Enter Your Phone No")
        }
        
        else if lastnameTextField.text == "" {
            alertAction(message: "Enter Your Password")
        }
        else{
            
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.SignupApiUrl, params: ["first_name":firstnameTextField.text!,"last_name":lastnameTextField.text!,"market_name":marketTextField.text!,"email":emailTextField.text!,"phone":phonenoTextField.text!,"password":passwordTextField.text!,"chat_id":"1"], success: { response in
            let data = self.parseResponseForLogin(response: response)
            if  let sellers = data as? Login {
                self.loginData = sellers
                print("Success Data")
                
                if self.loginData?.code == "200" {
                self.saveToFireBase()
                    
                    let viewController:LoginViewController = UIStoryboard(name: "Main", bundle: nil
                        ).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    viewController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                }
        else {
                    self.alertAction(message: "Email or Phone No Already Taken")
             }
                SVProgressHUD.dismiss()
                
            } else{
                print("error")
                SVProgressHUD.dismiss()
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
        
        
    }
    func parseResponseForLogin(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(Login.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
    
    func alertAction(message : String){
        
        let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }

    func design (){
        firstnameTextField.textfieldDesign()
        lastnameTextField.textfieldDesign()
        marketTextField.textfieldDesign()
        phonenoTextField.textfieldDesign()
        emailTextField.textfieldDesign()
        passwordTextField.textfieldDesign()
        
        loginBtn.layer.cornerRadius = 5
        registerBtn.layer.cornerRadius = 5
        registerBtn.setTitle("REGISTER", for: .normal)
        registerBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        registerBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
}
