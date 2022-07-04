//
//  ViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class LoginViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet var topView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()

        design()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    func design (){
        logoView.layer.cornerRadius = 15
        emailTextField.textfieldDesign()
        
        
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.clipsToBounds = true
        
        
        
        
        loginBtn.layer.cornerRadius = 5
        signupBtn.layer.cornerRadius = 5
        signupBtn.setTitle("REGISTER", for: .normal)
        signupBtn.setTitleColor(#colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1), for: .normal)
        signupBtn.layer.borderWidth = 1
        signupBtn.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4196078431, blue: 0.8117647059, alpha: 1)
        signupBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @IBAction func eyePressed(_ sender: UIButton) {
        if sender.isSelected
        {
            passwordTextField.isSecureTextEntry = true
            sender.isSelected = false
            
        }
        else {
            passwordTextField.isSecureTextEntry = false
            
            sender.isSelected = true
            
        }
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        logindata()
    }
    
    
    @IBAction func forgotPressed(_ sender: UIButton) {
        let viewController:RecoverAccountViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "RecoverAccountViewController") as! RecoverAccountViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        
        let viewController:SignupViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func logindata(){
    if passwordTextField.text == ""{
    alertAction(message: "Please Enter PhoneNo")
    }
    else if emailTextField.text == ""{
    alertAction(message: "Please Enter Password")
    }
    
    
                print("Loginpress")
                SVProgressHUD.show()
                RemoteRequest.requestPostURL(Constants.LoginAPiUrl, params: ["email":emailTextField.text!,"password":passwordTextField.text!], success: { response in
                let usersdata = self.parseResponseForLogin(response: response)
                SVProgressHUD.dismiss()
                // print(usersdata?.firstName)
                if  let login = usersdata as? Login {
                 Constants.user = login
                print("Success Data")
               let apiToken  =   login.data.apiToken ?? ""
                    UserDefaults.standard.set(login.data.apiToken ?? "", forKey: "api_token")


                SVProgressHUD.dismiss()
                if login.code == "200"{
                let viewController:TabViewController = UIStoryboard(name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                self.navigationController?.pushViewController(viewController, animated: true)
                
                }
                else if login.code == "201"{
                self.alertAction(message: "Credentails do not matched")
                }
                } else{
                print("error")
                }
                
                
                }) { error in
                }
    }
    func alertAction(message : String){
        
        let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    func parseResponseForLogin(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(Login?.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            self.alertAction(message: "Credentails do not matched")

            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }

}
extension UIViewController {
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
}
