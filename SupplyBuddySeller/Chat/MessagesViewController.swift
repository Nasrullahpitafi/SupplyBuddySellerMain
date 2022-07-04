//
//  MessagesViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 28/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit
import Firebase

struct msgStruct {
    
    var autoid : String
    var msgData : MsgData
}
struct MsgData {
    
    var isseen : String
    var sender : String
    var time : String
    var receiver : String
    var date : String
    var msg : String
    var type : String
}
class MessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var sendMsgField: UITextField!
    var ref: FIRDatabaseReference!
    var senderid : String = ""
    
    var currentDate = ""
    var currentTime = ""
    var msgArray = [msgStruct]()
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
      //  mytableview.reloadData()
       // initializeHideKeyboard()


        CurrentDate()
        CurrentTime()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
        mytableview.delegate = self
        mytableview.dataSource = self
        getMessages()
        mytableview.reloadData()
        sendMsgField.layer.cornerRadius = 5
        sendMsgField.layer.borderWidth = 1
        sendMsgField.layer.borderColor = #colorLiteral(red: 0.4196078431, green: 0.3176470588, blue: 0.6784313725, alpha: 0.9962275257)
        sendMsgField.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sendMsgField.clipsToBounds = true
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        if msgArray[indexPath.row].msgData.sender == Constants.user?.data.apiToken ?? "" {
            cell.receiverLabel.text! = msgArray[indexPath.row].msgData.msg
            cell.receiverDateLabel.text! = msgArray[indexPath.row].msgData.time
            cell.receiverLabel.layer.cornerRadius = 15
            cell.receiverDateLabel.isHidden = true
            cell.receiverLabel.isHidden = true

        }
        if msgArray[indexPath.row].msgData.receiver == Constants.user?.data.apiToken ?? "" {
            cell.senderLabel.text! = msgArray[indexPath.row].msgData.msg
            cell.senderDateLabel.text! = msgArray[indexPath.row].msgData.time
            cell.senderLabel.layer.cornerRadius = 15
            cell.senderLabel.layer.masksToBounds = true
        }
        
        
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
  
    @IBAction func sendPressed(_ sender: UIButton) {
        saveToFireBase()
        self.mytableview.reloadData()
        sendMsgField.text! = ""

    }
    func saveToFireBase(){
        let userData = ["sender": senderid as String ,
                        "receiver": Constants.user?.data.apiToken ?? "" as String,
                        "msg": sendMsgField.text! as String,
                        "isseen": "online" as String,
                        "type": "" as String,
                        "time": currentTime as String,
                        "date": currentDate as String,

        ]
        print(userData)
        self.ref.child("chat").child("\(senderid)\(Constants.user?.data.apiToken ?? "")").childByAutoId().setValue(userData)
        self.msgArray.append(msgStruct(autoid: "", msgData: MsgData.init(isseen: "", sender: "", time:currentTime , receiver: Constants.user?.data.apiToken ?? "" , date: currentDate, msg: sendMsgField.text! as String, type: "")))
        mytableview.reloadData()
    }
    func getMessages(){
   //     child("\(Constants.user?.data.apiToken ?? "")\(senderid)")
        let ref = FIRDatabase.database().reference().child("chat").child("\(senderid)\(Constants.user?.data.apiToken ?? "")")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? NSDictionary {
                print(userDict)
                for (key,value) in (snapshot.value as? NSDictionary)!
                {
                let newValue = value as? NSDictionary
                    let date = newValue?["date"] as? String ?? ""
                    let isseen = newValue?["isseen"] as? String ?? ""
                    let msg = newValue?["msg"] as? String ?? ""
                    let receiver = newValue?["receiver"] as? String ?? ""
                    let sender = newValue?["sender"] as? String ?? ""
                    let time = newValue?["time"] as? String ?? ""
                    let type = newValue?["type"] as? String ?? ""
                    
                    self.msgArray.append(msgStruct(autoid: (key as? String)!, msgData: MsgData.init(isseen: isseen, sender: sender, time: time, receiver: receiver, date: date, msg: msg, type: type)))
                    
                print(date)
               
                }
            //    self.mytableview.reloadData()

            }
            self.mytableview.reloadData()
            print(self.msgArray)
        })

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
}
