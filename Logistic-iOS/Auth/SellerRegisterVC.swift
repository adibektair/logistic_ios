//
//  SellerRegisterVC.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire

class SellerRegisterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var data = ["username", "password", "password1", "sellerCompanyBin", "sellerCompanyEmail" , "sellerCompanyMobilePhone", "sellerCompanyNameRu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var signUpButton: UIButton!{
        didSet{
            self.signUpButton.layer.cornerRadius = 5
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        var json = [String: String]()
        var index = IndexPath(row: 0, section: 0)
        for row in 0..<6 {
            index = IndexPath(row: row, section: 0)
            if let str = (tableView.cellForRow(at: index) as! RegisterCell).textField.text{
                if str == ""{
                    self.showAlert(title: "Внимание", message: "Заполните все поля")
                    break
                }
                json.updateValue(str, forKey: data[row])
            }
            
        }
        if json["password"] != json["password1"]{
            self.showAlert(title: "Внимание", message: "Пароли не совпадают")
            return
        }
        json.updateValue(json["sellerCompanyMobilePhone"]!, forKey: "sellerCompanyPhone")
        self.sellerSignUp(json: json, completionHandler: {success in
            if success{
                self.successVibration()
                self.signIn(json: json, completionHandler: {response in
                    if response{
                        self.singleVibration()
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
                        newViewController.selectedIndex = 2
                        self.present(newViewController, animated: true, completion: nil)
                    }
                })
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegisterCell
        let i = indexPath.row
        switch i {
        case 0:
            cell.label.text = "Придумайте логин"
            cell.textField.tag = i
            cell.textField.placeholder = "serik1992"
            break
        case 1:
            cell.label.text = "Придумайте пароль"
            cell.textField.tag = i
            cell.textField.isSecureTextEntry = true
            cell.textField.placeholder = "******"

            break
        case 2:
            cell.label.text = "Повторите пароль"
            cell.textField.tag = i
            cell.textField.isSecureTextEntry = true
            cell.textField.placeholder = "******"

            break
        case 3:
            cell.label.text = "Введите БИН"
            cell.textField.tag = i
            cell.textField.placeholder = "1231231"
            break
        case 4:
            cell.label.text = "Введите email"
            cell.textField.tag = i
            cell.textField.placeholder = "serik1992@mail.kz"
            cell.textField.keyboardType = .emailAddress
            break
        case 5:
            cell.label.text = "Введите телефон"
            cell.textField.tag = i
            cell.textField.placeholder = "+77005554797"
            cell.textField.keyboardType = .phonePad

            break
        case 6:
            cell.label.text = "Введите имя"
            cell.textField.tag = i
            cell.textField.placeholder = "Серік Берікұлы"
            cell.textField.autocapitalizationType = .words
            break
        default:
            break
        }
        return cell
    }
}
extension SellerRegisterVC{
    func sellerSignUp(json: [String: String], completionHandler: @escaping (_ res: Bool) -> ()) {
        Alamofire.request(url + "seller/company/addJson", method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON{
            (response) in
            if let code = response.response?.statusCode{
//                let jsonData = JSONSerialization.data(withJSONObject: response, options: nil)
                
                if code == 200{
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
            }
        }
    }
}
