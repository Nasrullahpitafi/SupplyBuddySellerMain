//
//  RecoverAccountViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 24/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
class RecoverAccountViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var recoverBtn: UIButton!
    
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()

        design()
        // Do any additional setup after loading the view.
    }
    
    func design (){
        emailField.textfieldDesign()
        recoverBtn.layer.cornerRadius = 5
        loginBtn.layer.cornerRadius = 5
        loginBtn.setTitle("LOGIN", for: .normal)
        loginBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        loginBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    @IBAction func recovernowPressed(_ sender: UIButton) {
        ForgotPassword()
    }
    func ForgotPassword(){
        SVProgressHUD.show()
        RemoteRequest.requestPostURL(Constants.fotgotPasswordApiUrl, params: ["email":emailField.text!], success: { response in
            let data = self.parseResponseForLogin(response: response)
            if  let sellers = data as? ForgotPasswordModel {
                
                print("Success Data")
                if sellers.code == "0" {
                    self.alertAction(message: "Email not found!")
                }
                else if sellers.code == "1"{
                    let viewController:AddOTPViewController = UIStoryboard(name: "Main", bundle: nil
                        ).instantiateViewController(withIdentifier: "AddOTPViewController") as! AddOTPViewController
                    viewController.email = self.emailField.text!
                    self.navigationController?.pushViewController(viewController, animated: true)
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
    func parseResponseForLogin(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(ForgotPasswordModel.self, from: jsonData!)
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
