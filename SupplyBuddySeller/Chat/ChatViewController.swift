//
//  ChatViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 28/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import Firebase

struct Object {
    
    var apiKey : String
    var values : Deta
}
struct Deta {
    var id : String
    var name : String
    var date : String
    var img : String
    var status : String
    var type : String
    var time : String
}

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var objectArray = [Object]()
    var ref: FIRDatabaseReference!

    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        mytableview.reloadData()
      //  initializeHideKeyboard()
        mytableview.delegate = self
        mytableview.dataSource = self
        

        mytableview.allowsSelection = true
       

    }
    override func viewWillAppear(_ animated: Bool) {
        
        getFireBaseData()
        mytableview.reloadData()
        
    }
    func getFireBaseData(){
        let ref = FIRDatabase.database().reference().child("Users")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? NSDictionary {
                
                for (key,value) in (snapshot.value as? NSDictionary)!{
                    let newvalue = value as? NSDictionary
                    let id = newvalue?["id"] as? String ?? ""
                    let name = newvalue?["name"] as? String ?? ""
                    let date = newvalue?["date"] as? String ?? ""
                    let img = newvalue?["img"] as? String ?? ""
                    let status = newvalue?["status"] as? String ?? ""
                    let type = newvalue?["type"] as? String ?? ""
                    let time = newvalue?["time"] as? String ?? ""
                    
                    if type == "seller"
                    {
                    self.objectArray.append(Object(apiKey: key as! String, values: Deta.init(id: id, name:name, date: date, img: img, status: status, type: type, time: time)))
                    }
                }

            }

            print(self.objectArray)
            self.mytableview.reloadData()
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  objectArray.count ?? 0
        print(objectArray.count ?? 0)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        cell.nameLabel.text! = objectArray[indexPath.row].values.name
        cell.dateLabel.text! = objectArray[indexPath.row].values.time
        if objectArray[indexPath.row].values.status == "online"{
            cell.onlineImage.isHidden = false
        }
        else{
            cell.onlineImage.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath)
        let viewController:MessagesViewController = UIStoryboard(name: "Main", bundle: nil
            ).instantiateViewController(withIdentifier: "MessagesViewController") as! MessagesViewController
        viewController.senderid = objectArray[indexPath.row].values.id ?? ""

        self.navigationController?.pushViewController(viewController, animated: true)
        
    }

}
