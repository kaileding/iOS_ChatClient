//
//  ViewController.swift
//  ChatClient
//
//  Created by DINGKaile on 10/26/16.
//  Copyright © 2016 myPersonalProjects. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    var user: PFUser?
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBAction func doSignup(_ sender: AnyObject) {
        user = PFUser()
        user?.username = usernameText.text!
        user?.password = passwordText.text!
        user?.email = emailText.text!
        
        user?.signUpInBackground {
            (succeeded:  Bool, error: Error?) -> Void in
            if let error = error {
                print(error)
            }else{
                print("Succeeded to sign up")
                self.performSegue(withIdentifier: "showToChat", sender: self)
                /*
                let vc = ChatViewController()
                self.present(vc, animated: true, completion: {
                    print("OK")
                })
                */
                
            }
        }
        
    }
    @IBAction func doSignIn(_ sender: AnyObject) {
        //do{
        user = try?  PFUser.logIn(withUsername: usernameText.text!, password: passwordText.text!)
        if user == nil {
            print("Failed to login \(usernameText.text!)")
            return
        }
        
        print("Succeeded to login \(usernameText.text!)")
        self.performSegue(withIdentifier: "showToChat", sender: self)
//        
//        let vc = ChatViewController()
//        self.present(vc, animated: true, completion: {
//            print("OK")
//        })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? UINavigationController{
            if let chatVC = vc.viewControllers[0] as? ChatViewController {
                chatVC.user = user
            }
        }
        
    }
}

