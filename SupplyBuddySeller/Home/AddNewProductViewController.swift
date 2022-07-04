//
//  AddNewControllerViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import SVProgressHUD
import OpalImagePicker
import Alamofire
import iOSDropDown
class AddNewProductViewController: UIViewController,OpalImagePickerControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    
    @IBOutlet weak var CategoryField: DropDown!
    
    @IBOutlet weak var SubCategoryField: DropDown!
    
    @IBOutlet weak var budgestField: UITextField!
    
    @IBOutlet weak var discountField: UITextField!
    
    @IBOutlet weak var availablestockField: UITextField!
    
    @IBOutlet weak var capacityField: UITextField!
    
    @IBOutlet weak var productunitField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var addproductBtn: UIButton!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var buttonImage: UIImageView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var imagesArryay = [UIImage]()
    var categoryArray = [String]()
    var SubcategoryArray = [String]()

    var newimageData : Data?
    
    @IBOutlet weak var mediaView: UIView!
    
    var active : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaView.isHidden = true
        design()
    //    initializeHideKeyboard()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        GetCategories()
        GetSubCategories()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
      //  navigationController?.isNavigationBarHidden = false
        
     
    }
    override func viewWillDisappear(_ animated: Bool) {
      //  navigationController?.isNavigationBarHidden = true

    }
    func design (){
        CategoryField.textfieldDesign()
        SubCategoryField.textfieldDesign()
        nameField.textfieldDesign()
        budgestField.textfieldDesign()
        discountField.textfieldDesign()
        availablestockField.textfieldDesign()
        capacityField.textfieldDesign()
        productunitField.textfieldDesign()
        descriptionField.textfieldDesign()
    }
    
    @IBAction func SwitchPressed(_ sender: UISwitch) {
        
        if `switch`.isOn {
            print("ON")
            active = "1"
        }
        else {
            active = "0"
            print ("OFF")
        }
    }
    @IBAction func addproductPressed(_ sender: UIButton) {
        imageupload()
    }
    
    @IBAction func galleryPressed(_ sender: UIButton) {
        print("photolibrary Pressed")
        var imagePicker: OpalImagePickerController!
        imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self as! OpalImagePickerControllerDelegate
        imagePicker.selectionImage = UIImage(named: "aCheckImg")
        imagePicker.maximumSelectionsAllowed = 20 // Number of selected images
        
        present(imagePicker, animated: true, completion: nil)
    }
    func imageupload(){
        SVProgressHUD.show()
        let parameters = [
            "api_token":Constants.user?.data.apiToken ?? ""
            ]
        
        let myimage = UIImage(named: "location")
        let imgData = myimage!.jpegData(compressionQuality: 0.50)
        
        for (_,item) in imagesArryay.enumerated(){
            let myimageData = item.jpegData(compressionQuality: 0.50)
            newimageData = myimageData
        

        }
        
        
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                
                for (key, value) in parameters {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }

                MultipartFormData.append(self.newimageData!, withName: "images[]", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                DispatchQueue.main.async {
                    MultipartFormData.append(self.nameField.text!.data(using: .utf8)!, withName: "name")
                    MultipartFormData.append(self.CategoryField.text!.data(using: .utf8)!, withName: "category_id")
                //    MultipartFormData.append((Constants.user?.data.apiToken?.data(using: .utf8))!, withName: "api_token")
                    MultipartFormData.append(self.SubCategoryField.text!.data(using: .utf8)!, withName: "subcategory_id")
                    MultipartFormData.append(self.budgestField.text!.data(using: .utf8)!, withName: "price")
                    MultipartFormData.append(self.descriptionField.text!.data(using: .utf8)!, withName: "description")
                    MultipartFormData.append(self.discountField.text!.data(using: .utf8)!, withName: "discount")
                    MultipartFormData.append((self.availablestockField.text!.data(using: .utf8)!), withName: "available")
                    MultipartFormData.append(self.availablestockField.text!.data(using: .utf8)!, withName: "stock")
                    MultipartFormData.append(self.capacityField.text!.data(using: .utf8)!, withName: "capacity")
                    MultipartFormData.append(self.productunitField.text!.data(using: .utf8)!, withName: "unit")
                    
                }
                
                
                
        }, to: "https://supplybuddy.dedicatedevs.com/api/seller/addproduct") { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    print(response.result.value)
                    
                    let dic = response.result.value as? NSDictionary
                    
                    let message = dic?["msg"] as? String
                    print(message ?? "")
                    self.alertAction(message: message ?? "")
                    
                    SVProgressHUD.dismiss()
                }
                
            case .failure(let encodingError): break
            SVProgressHUD.dismiss()

            print(encodingError)
            }
            
            SVProgressHUD.dismiss()

        }
    }
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        print("Done Pressed")
        mediaView.isHidden = true
        print(images)
        buttonImage.isHidden = true
        imagesArryay = images
        myCollectionView.reloadData()
        
        presentedViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func cameraPressed(_ sender: UIButton) {
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        mediaView.isHidden = true

    }
    @IBAction func ChoosImages(_ sender: Any) {
        mediaView.isHidden = false

    }
    func GetCategories()
    {
        RemoteRequest.requestGetURL(Constants.CategoriesApiUrl, params: [:], success: { response in
          
          let Dic = response as! NSDictionary
          print(Dic)
          let data = Dic["data"] as! [NSDictionary]
            for values in data
            {
                print(values["name"] as? String)
                self.categoryArray.append(values["name"] as! String)
            }
            print(self.categoryArray)
            self.CategoryField.text! = self.categoryArray[0]
            self.CategoryField.optionArray = self.categoryArray
            self.CategoryField.selectedRowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

            self.CategoryField.didSelect { (selectedText, index, id) in
                print("\(selectedText)\(index)\(id)")
            }
            
            
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    func GetSubCategories()
    {
        RemoteRequest.requestGetURL(Constants.SubcategoryApiUrl, params: [:], success: { response in
            
            let Dic = response as! NSDictionary
            print(Dic)
            let data = Dic["data"] as! [NSDictionary]
            for values in data
            {
                print(values["name"] as? String)
                self.SubcategoryArray.append(values["name"] as! String)
            }
            print(self.SubcategoryArray)
            self.SubCategoryField.text! = self.SubcategoryArray[0]
            self.SubCategoryField.optionArray = self.SubcategoryArray
            self.SubCategoryField.selectedRowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            self.SubCategoryField.didSelect { (selectedText, index, id) in
                print("\(selectedText)\(index)\(id)")
            }
        }) { error in
            SVProgressHUD.dismiss()
        }
    }
    func AddProducts(){
        SVProgressHUD.show()
        
        let image = UIImage(named: "location")
        let imageData =   image!.jpegData(compressionQuality: 0.50)
        
        RemoteRequest.requestPostURL(Constants.AddProductAPiUrl, params: ["api_token":Constants.user?.data.apiToken ?? "","category_id":"1","subcategory_id":"1","name":nameField.text!,"description":descriptionField.text!,"images[]":imageData,"price":budgestField.text!,"discount":discountField.text!,"stock":availablestockField.text!,"available":"1","capacity":capacityField.text!,"unit":productunitField.text!], success: { response in
            let data = self.parseResponseForAddProduct(response: response)
            if  let sellers = data as? AddProductModel {
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
    func parseResponseForAddProduct(response:Any)->AnyObject?{
        let jsonData = try? JSONSerialization.data(withJSONObject: response, options: JSONSerialization.WritingOptions.prettyPrinted)
        do {
            //let dict = response as! NSDictionary
            let state = try JSONDecoder().decode(AddProductModel.self, from: jsonData!)
            return state as AnyObject
        }
        catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
            
            return nil
        }
        return nil
    }
    func alertAction(message : String){
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }

}
extension AddNewProductViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArryay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ImagesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagesCollectionViewCell
        cell.myimage.image = imagesArryay[indexPath.row]
        
        return cell
    }
    
    
}
