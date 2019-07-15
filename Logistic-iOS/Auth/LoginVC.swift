//
//  LoginVC.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire
class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Войти"
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            self.loginButton.layer.cornerRadius = 5
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
        newViewController.selectedIndex = 0
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBAction func loginPressed(_ sender: Any) {
        self.startLoading()
        if usernameTextField.text != "" && passwordTextField.text != ""{
            let json = ["username" : usernameTextField.text!,
                        "password" : passwordTextField.text!
            ] as [String: String]
            self.signIn(json: json, completionHandler: { response in
                self.stopLoading()
                if response{
                    self.singleVibration()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
                    newViewController.selectedIndex = 2
                    self.present(newViewController, animated: true, completion: nil)
                }
            })
        }else{
            self.showAlert(title: "Внимание", message: "Заполните все поля")
        }
    }
    
}
extension UIViewController{
    func signIn(json: [String: String], completionHandler: @escaping (_ res: Bool) -> ()) {
        Alamofire.request(url + "authentication/loginObject", method: .post, parameters: json, encoding: URLEncoding.default, headers: nil).responseObject{
            (response: DataResponse<LoginData>) in
            if let responseCode = response.response?.statusCode{
                if responseCode == 200{
                    
                    let info = response.result.value
                    var isSeller: Bool?
                    if let id = info?.customerId{
                        if id == 0{
                            isSeller = true
                            UserDefaults.standard.set(info!.sellerCompanyId, forKey: "id")
                        }else{
                            isSeller = false
                            UserDefaults.standard.set(info!.customerId, forKey: "id")
                        }
                    }
                    UserDefaults.standard.set(isSeller, forKey: "isSeller")

                    UserDefaults.standard.set(info?.username, forKey: "username")
                    completionHandler(true)
                }else{
                    self.showAlert(title: "Ошибка", message: "Перепроверьте введенные данные")
                }
            }
        }
    }
}
