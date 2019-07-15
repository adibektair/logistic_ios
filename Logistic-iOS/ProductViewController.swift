//
//  ProductViewController.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var product: Product?
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let name = product?.productNameRu{
            self.title = name
        }
        
    }
    
    @IBOutlet var makeOrder: UIButton!{
        didSet{
            self.makeOrder.layer.cornerRadius = 5
        }
    }
    @IBAction func makeOrderPressed(_ sender: Any) {
        let id = UserDefaults.standard.string(forKey: "username")
        if id == nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tab") as! TabBarController
            newViewController.selectedIndex = 2
            self.present(newViewController, animated: true, completion: nil)
            return
        }
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        let formattedDate = format.string(from: date)
        
        let json = [
            "customerId":UserDefaults.standard.integer(forKey: "id"),
            "deliveringStatus":"waiting",
            "orderAmount":1,
            "orderDate":formattedDate,
            "productAmount":1,
            "productCount":1,
            "productId":product!.productId,
            "sellerCompanyId":product!.sellerCompanyId,
            "totalPrice":product!.price,
            "unitPrice":product!.price
        ] as [String: AnyObject]
        
        self.makeOrder(json: json, completionHandler: {
            success in
            if success{
                self.showAlert(title: "Успешно", message: "Заказ успешно оформлен")
                self.singleVibration()
            }else{
                self.showAlert(title: "Ошибка", message: "Пожалуйста, попробуйте позже")

            }
        })
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        if i == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageViewCell
            if let url = product?.photoUrlsList{
                let fullNameArr = url.components(separatedBy: ",")
                var name = ""
                if fullNameArr.count == 0{
                    name = url

                }else{
                    name = fullNameArr[0]

                }
                
                cell.imgView!.sd_setImage(with: URL(string: "http://87.255.197.72:8080/product/uploads/" + name), placeholderImage: #imageLiteral(resourceName: "map"))
            }else{
                cell.imgView!.image = #imageLiteral(resourceName: "layers")
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
            switch i{
                case 1:
                    cell.textLabel?.text = "Описание: " + (product?.productDescription!)!
                    break
                case 2:
                    cell.textLabel?.text = "Производитель: " +  (product?.manufacturer!)!
                    break
                case 3:
                    cell.textLabel?.text = "Размер: " +  (product?.size!)!
                    break
                case 4:
                    cell.textLabel?.text = "Вес: \((product?.weight!)!)"
                    break
                default:
                    break
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return UIScreen.main.bounds.width
        }else{
            return 25.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}

extension ProductViewController{
    
    func makeOrder(json: [String: AnyObject], completionHandler: @escaping (_ res: Bool) -> ()) {
            Alamofire.request(url + "order/addJson", method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).response{
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
