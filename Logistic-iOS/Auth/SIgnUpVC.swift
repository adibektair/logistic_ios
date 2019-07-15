//
//  SIgnUpVC.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire

class SIgnUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Зарегистрироваться"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password1TextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            self.signUpButton.layer.cornerRadius = 5
        }
    }
    @IBAction func signUp(_ sender: Any) {
        self.startLoading()
        if usernameTextField.text != "" && passwordTextField.text != "" && password1TextField.text != "" && nameTextField.text != ""{
            if(password1TextField.text == passwordTextField.text){
                let json = [
                    "password" : password1TextField.text!,
                    "username" : usernameTextField.text!,
                    "customerNameRu" : nameTextField.text!
                ] as [String:String]
                self.signUp(json: json, completionHandler: { success in
                    self.stopLoading()
                    if success{
                            self.signIn(json: json, completionHandler: {response in
                                if response{
                                    self.singleVibration()
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
                                    newViewController.selectedIndex = 2
                                    self.present(newViewController, animated: true, completion: nil)
                                }
                            })
                    }else{
                        self.showAlert(title: "Внимание", message: "Произошла непредвиденная ошибка, повторите позже")
                    }
                })
            }else{
                self.showAlert(title: "Ошибка", message: "Пароли не совпадают")
            }
        }else{
            self.showAlert(title: "Внимание", message: "Заполните все поля")
        }
    }
    
}
extension SIgnUpVC{
    func signUp(json: [String: String], completionHandler: @escaping (_ res: Bool) -> ()) {
        Alamofire.request(url + "customer/add", method: .post, parameters: json, encoding: URLEncoding.default, headers: nil).response{
            (response) in
            if let code = response.response?.statusCode{
                if code == 200{
                   completionHandler(true)
                }else{
                    completionHandler(false)
                }
            }
        }   
    }
}
