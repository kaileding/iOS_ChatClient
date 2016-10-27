//
//  ChatViewController.swift
//  ChatClient
//
//  Created by hideki on 10/26/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatBox: UITextField!
    
    @IBOutlet weak var messageTable: UITableView!
    
    var messageList = [String]()
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        
        self.messageTable.dataSource = self
        self.messageTable.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear \(user)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func onSendPressed(_ sender: AnyObject) {
        
        let message = PFObject(className: "Message")
        message["text"] = self.chatBox.text
        message["username"] = PFUser.current()?.username
        message["user"] = PFUser.current()
        
        
        message.saveInBackground { (success, error) in
            if success {
                print("successfully sent a message")
            } else {
                print("failed to send a message")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatContentCell", for: indexPath) as! ChatViewCell
        cell.messageLabel.text = self.messageList[indexPath.row]
        
        return cell
        
    }
    
    
    func onTimer() {
        // print("\n\ntimer fired\n\n")
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        //query.includeKey("username")
        //query.whereKey("email", equalTo: user?.email)
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (array, error) in
            
            if error == nil {
                if let objects = array {
                    self.messageList.removeAll()
                    
                    // self.messageList = objects

                    for object in objects {
                        print("object id is: \(object.objectId!)")
                        print("object.createdAt is \(object.createdAt!)")
                        
                        if let str = object["text"] as? String {
                            if let user = object["user"] as? PFUser {
                                self.messageList.append(str + "\n" + user.username!)
                                print(str)
                            }
                        }
//                        self.messageList?.append(object)
                    }
                    
                    self.messageTable.reloadData()
                }
            }
        }
        
    }

}
