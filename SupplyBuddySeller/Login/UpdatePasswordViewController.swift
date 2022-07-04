//
//  UpdatePasswordViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 24/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var newpassField: UITextField!
    
    @IBOutlet weak var confirmpassField: UITextField!
    
    @IBOutlet weak var recBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var email : String = ""
    var pass : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        emailField.text! = email
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    
    func design (){
        emailField.textfieldDesign()
        newpassField.textfieldDesign()
        confirmpassField.textfieldDesign()
        recBtn.layer.cornerRadius = 5
        loginBtn.layer.cornerRadius = 5
        loginBtn.setTitle("LOGIN", for: .normal)
        loginBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        loginBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    @IBAction func recovernowPressed(_ sender: UIButton) {
        var a = false
        var b = false
        
        if newpassField.text! == confirmpassField.text! {
            
            a = true
            
        } else {
            alertAction(message: "Password and confirm Password Not Matched")

        }
        
        if(newpassField.text! == "" || confirmpassField.text! == "") {
            //alert saying there are empty fields
            alertAction(message: "Fields are Empty")
            
        } else {
            
            b = true
        }
        
        if a == true && b == true {
            pass = newpassField.text!
            updatepassword()
            
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
    func updatepassword(){
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.updatePassAPiUrl, params: ["email":email,"password":pass], success: { response in
            let data = self.parseResponseForLogin(response: response)
            if  let sellers = data as? UpdatePassModel? {
                
                print("Success Data")
                
                let viewController:LoginViewController = UIStoryboard(name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(viewController, animated: true)
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
            let state = try JSONDecoder().decode(UpdatePassModel?.self, from: jsonData!)
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
}
