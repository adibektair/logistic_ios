//
//  ProfileVC.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {


    
    @IBOutlet var addButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.addButton.isHidden = true
        self.title = "Профиль"
        let id = UserDefaults.standard.string(forKey: "username")
        if id == nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "login") as! NavVC
            self.present(newViewController, animated: true, completion: nil)
            
        }else{
            if UserDefaults.standard.bool(forKey: "isSeller"){
                self.addButton.isHidden = false
            }
            
            self.usernameLabel.text = "Здравствуйте, " +  id!
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "isSeller")
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        self.singleVibration()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
        newViewController.selectedIndex = 0
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
