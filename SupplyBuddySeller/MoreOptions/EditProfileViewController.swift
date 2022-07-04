//
//  EditProfileViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
class EditProfileViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var firstnameField: UITextField!
    
    @IBOutlet weak var marketnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         firstnameField.text! = Constants.user?.data.firstName ?? ""
        lastnameField.text! = Constants.user?.data.lastName ?? ""
        marketnameField.text! = Constants.user?.data.marketName ?? ""
        design()
        profileImage()
        setprofileimage()
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraBtn(_ sender: UIButton) {
        print("photolibrary Pressed")
        let mypickercontroller = UIImagePickerController()
        mypickercontroller.delegate = self
        mypickercontroller.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(mypickercontroller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let   resizedImage = image?.resized(toWidth: 100)
        //  let  base64string = convertImageToBase64(resizedImage!)
        profileimage.image = resizedImage
        profileimage.backgroundColor = UIColor.clear
        
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func updatePressed(_ sender: UIButton) {
        UpdateProfilee()
    }
    func design (){
        firstnameField.textfieldDesign()
        lastnameField.textfieldDesign()
        marketnameField.textfieldDesign()
        
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
    func UpdateProfilee(){
        let parameters = [
            "":""
        ]
        
     
        let imgData = self.profileimage.image!.jpegData(compressionQuality: 0.50)
        
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
                MultipartFormData.append(imgData!, withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                DispatchQueue.main.async {
                    MultipartFormData.append(self.firstnameField.text!.data(using: .utf8)!, withName: "first_name")
                    MultipartFormData.append(self.lastnameField.text!.data(using: .utf8)!, withName: "last_name")
                    MultipartFormData.append(self.marketnameField.text!.data(using: .utf8)!, withName: "market_name")
                    MultipartFormData.append((Constants.user?.data.apiToken!.data(using: .utf8)!)!, withName: "api_token")
              
                    
                }
                
                
                
        }, to: "https://supplybuddy.dedicatedevs.com/api/seller/update/profile") { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    let dic = response.result.value as? NSDictionary
                    
                    let message = dic?["message"] as? String
                    print(message ?? "")
                    self.alertAction(message: message ?? "")
                    
                    print(response.result.value)
                }
                
            case .failure(let encodingError): break
            print(encodingError)
            }
            
            
        }
    }
    func alertAction(message : String){
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
}
