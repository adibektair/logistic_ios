//
//  Extensions.swift
//  Takon
//
//  Created by Adibek on 08.02.2018.
//  Copyright © 2018 Maint. All rights reserved.
//
//

import UIKit

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UIView
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        self.endEditing(true)
    }
}
let dark = UIView()
let small = UIView()
var indicator = UIActivityIndicatorView()

extension UIViewController{
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func successVibration(){
        let impact = UIImpactFeedbackGenerator()
        let selection = UISelectionFeedbackGenerator()
        let notification = UINotificationFeedbackGenerator()
        
        notification.notificationOccurred(.success)
        
    }
    func errorVibration(){
        let impact = UIImpactFeedbackGenerator()
        let selection = UISelectionFeedbackGenerator()
        let notification = UINotificationFeedbackGenerator()
        
        notification.notificationOccurred(.error)
    }
    func singleVibration(){
        let impact = UIImpactFeedbackGenerator()
        impact.impactOccurred()
    }
    func startLoading(){
        
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        dark.frame = CGRect(x: 0, y: 0, width: w, height: h)
        dark.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        small.frame.size = CGSize(width: w * 0.25, height: w * 0.25)
        small.backgroundColor = UIColor.white
        small.layer.cornerRadius = 15
        small.center = dark.center
        indicator.style = .gray
        indicator.color = UIColor.black
        indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicator.transform = transform
        indicator.center = dark.center
        
        
        
        
        
        //        indicator.center = small.center
        
        //        small.addSubview(indicator)
        dark.addSubview(small)
        dark.addSubview(indicator)
        view.addSubview(dark)
        indicator.startAnimating()
    }
    func stopLoading(){
        dark.removeFromSuperview()
    }
    
    
}
