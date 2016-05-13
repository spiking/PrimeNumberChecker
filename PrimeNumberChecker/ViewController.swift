//
//  ViewController.swift
//  PrimeNumberChecker
//
//  Created by Adam Thuvesen on 2016-05-13.
//  Copyright © 2016 Adam Thuvesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var enteredValue = 0
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var enterTextField: MyCustomTextField!
    
    @IBOutlet weak var wrongImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        self.enterTextField.delegate = self
    }
    
    @IBAction func calculateAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        if enterTextField.text != nil && enterTextField.text != "" {
            
            enteredValue = Int(enterTextField.text!)!
            
            if isPrime(enteredValue) {
                checkImage.hidden = false
                print("Prime!")
            } else {
                wrongImage.hidden = false
                print("Not prime!")
            }
        }
    }
    
    func isPrime(n: Int) -> Bool {
        if n <= 1 {
            return false
        }
        
        if n <= 3 {
            return true
        }
        
        var i = 2
        while i*i <= n {
            if n % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        checkImage.hidden = true
        wrongImage.hidden = true
        print("Editing...")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            logoImage.hidden = true
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            logoImage.hidden = false
            self.view.frame.origin.y += keyboardSize.height
        }
    }

}

