//
//  AddProductVC.swift
//  Logistic-iOS
//
//  Created by User on 6/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import Alamofire

class AddProductVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var keys = ["productNameEn", "productDescription",  "manufacturer", "price", "size", "weight", "productCategoryId",  "productSubcategoryId", "sellerCompanyId", "serialNumber",  "specialCharacteristicId", "uniqueIdNumber"]
    
    var categories = [Category]()
    var subcategories = [Subcategory]()
    var selectedCategoryId = 0
    var selectedSubCategoryId = 0

    var isCategory = true
    var darkView = UIView(){
        didSet{
            self.darkView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.darkView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
        }
    }
    override func viewDidLoad() {
        self.title = "Добавить товар"
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

    }
    var imagePicker: ImagePicker!

    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var whiteView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sendButton: UIButton!{
        didSet{
            self.sendButton.layer.cornerRadius = 5
        }
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        var index = IndexPath(row: 1, section: 0)
        tableView.scrollToRow(at: index, at: .top, animated: true)
        self.startLoading()
        view.endEditing(true)
        if selectedSubCategoryId != 0 && selectedCategoryId != 0{
            var json = [String: String]()
            
            
            for row in 1..<7 {
                index = IndexPath(row: row, section: 0)
                if let str = (tableView.cellForRow(at: index) as? RegisterCell)?.textField.text{
                    if str == ""{
                        self.showAlert(title: "Внимание", message: "Заполните все поля")
                        self.stopLoading()
                        return
                    }
                    json.updateValue(str, forKey: keys[row - 1])
                }
            }
            json["productNameKk"] = json["productNameEn"]
            json["productNameRu"] = json["productNameEn"]
            json["sellerCompanyId"] = "\(UserDefaults.standard.integer(forKey: "id"))"

            json["serialNumer"] = "\(Int.random(in: 0..<1000000))"
            json["specialCharacteristicId"] = "1"
            json["uniqueIdNumber"] = "\(Int.random(in: 0..<1000000))"
            json["productCategoryId"] = "\(self.selectedCategoryId)"
            json["productSubcategoryId"] = "\(self.selectedSubCategoryId)"
            self.addProduct(json: json, completionHandler: { success in
                self.stopLoading()
                if success{
                    self.singleVibration()
                    self.showAlert(title: "Успешно", message: "Товар отправлен на модерацию")
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.showAlert(title: "Внимание", message: "Произошла ошибка, перепроверьте введенные данные")
                }
            })
            
            
        }else{
            self.stopLoading()
            self.showAlert(title: "Выберите категорию и подкатегорию", message: "")
        }
    }
    
    
    @IBAction func done(_ sender: Any) {
        self.whiteView.removeFromSuperview()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isCategory{
            return categories.count
        }
        return subcategories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isCategory{
            return categories[row].categoryName!.ru!
        }
        return subcategories[row].subcategoryName!.ru!
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isCategory{
            self.selectedCategoryId = categories[row].productCategoryId!
            var index = IndexPath(row: 7, section: 0)
            let cell = tableView.cellForRow(at: index) as! PickerCell
            cell.label.text = categories[row].categoryName!.ru!
            
        }else{
            self.selectedSubCategoryId = subcategories[row].productSubcategoryId!
            var index = IndexPath(row: 8, section: 0)
            let cell = tableView.cellForRow(at: index) as! PickerCell
            cell.label.text = subcategories[row].subcategoryName!.ru!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegisterCell
        let pickerCell = tableView.dequeueReusableCell(withIdentifier: "pickerCell", for: indexPath) as! PickerCell
        
        switch i {
        case 0:
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
            return imageCell
        case 1:
            cell.label.text = "Введите название продукта"
            cell.textField.placeholder = "Духи"
            return cell

        case 2:
            cell.label.text = "Введите описание продукта"
            cell.textField.placeholder = "Очень вкусно пахнут"
            return cell
        case 3:
            cell.label.text = "Производитель"
            cell.textField.placeholder = "Chanel"
            return cell
        case 4:
            cell.label.text = "Цена"
            cell.textField.placeholder = "1000"
            cell.textField.keyboardType = .numberPad
            return cell

        case 5:
            cell.label.text = "Размер"
            cell.textField.placeholder = "S"
            return cell
        case 6:
            cell.label.text = "Вес в кг"
            cell.textField.placeholder = "0.1"
            return cell
        case 7:
            pickerCell.label.text = "Выберите категорию товара"

            return pickerCell
        case 8:
            pickerCell.label.text = "Выберите подкатегорию товара"
            return pickerCell
        default:
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.imagePicker.present(from: tableView)
        case 7:
            self.getCategories(completionHandler: {
                cats in
                self.categories = cats
                self.isCategory = true
                self.pickerView.reloadAllComponents()
                self.whiteView.frame = CGRect(x: 10, y: (UIScreen.main.bounds.height / 2) - 170, width: UIScreen.main.bounds.width - 20, height: 300)
                self.view.addSubview(self.whiteView)
            })
        case 8:
            if selectedCategoryId != 0{
                self.getSubcategories(category_id: self.selectedCategoryId, completionHandler: {
                    subs in
                    if subs.count == 0{
                        self.showAlert(title: "Ошибка", message: "В этой категории нет подкатегорий")
                        return
                    }
                    self.subcategories = subs
                    self.isCategory = false

                    self.pickerView.reloadAllComponents()
                    self.whiteView.frame = CGRect(x: 10, y: (UIScreen.main.bounds.height / 2) - 170, width: UIScreen.main.bounds.width - 20, height: 300)
                    self.view.addSubview(self.whiteView)
                })
            }
        default:
            break
        }
        
    }
    
}

extension AddProductVC: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        var index = IndexPath(row: 0, section: 0)

        var imageView = (tableView.cellForRow(at: index) as! ImageCell).imgView
        imageView?.image = image
    }
}
extension AddProductVC{
    func addProduct(json: [String: String], completionHandler: @escaping (_ res: Bool) -> ()) {
        Alamofire.request(url + "product/addJson", method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).response{
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
