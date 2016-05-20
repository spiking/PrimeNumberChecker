//
//  ViewController.swift
//  PrimeNumberChecker
//
//  Created by Adam Thuvesen on 2016-05-13.
//  Copyright © 2016 Adam Thuvesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var enteredValue: CLongLong = 0
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var enterTextField: MyCustomTextField!
    @IBOutlet weak var wrongImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add tap gesture to be able to hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Be able to push view up/down when keyboard is shown
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // To customize the textfield
        self.enterTextField.delegate = self
    }
    
    @IBAction func calculateAction(sender: AnyObject) {
        
        dismissKeyboard()
        
        if enterTextField.text != nil && enterTextField.text != "" {
            if enterTextField.text!.characters.count > 18 {
                showHighNumberAlert()
            } else {
                enteredValue = CLongLong(enterTextField.text!)!
                if isPrime(enteredValue) {
                    animateResult("checkImage")
                } else {
                    animateResult("wrongImage")
                }
            }
        } else {
            showNoInputAlert()
        }
    }
    
    func isPrime(n: CLongLong) -> Bool {
        if n <= 1 {
            return false
        }
        
        if n <= 3 {
            return true
        }
        
        var i: CLongLong = 2
        while i*i <= n {
            if n % i == 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    func animateResult(type: String) {
        
        if type == "checkImage" {
            UIView.animateWithDuration(1.5, delay:0.0, options:UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.checkImage.alpha = 1
                self.resultLabel.alpha = 1
                self.resultLabel.text = "\(self.enteredValue) IS A PRIME"
                
                }, completion: { finished in
                    print("Done - prime!")
            })
        } else {
            UIView.animateWithDuration(1.5, delay:0.0, options:UIViewAnimationOptions.CurveEaseIn, animations: {
                
                self.wrongImage.alpha = 1
                self.resultLabel.alpha = 1
                self.resultLabel.text = "\(self.enteredValue) IS NOT A PRIME"
                
                }, completion: { finished in
                        print("Done - not prime!")
            })
        }
    }
    
    func showHighNumberAlert() {
        let alert = UIAlertController(title: "Too high number", message: "Please enter a lower number.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showNoInputAlert() {
        let alert = UIAlertController(title: "No number entered", message: "Please enter a number.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // Only take numerical input, ipad
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
        let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
        let numberFiltered = compSepByCharInSet.joinWithSeparator("")
        return string == numberFiltered
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        checkImage.alpha = 0
        wrongImage.alpha = 0
        resultLabel.alpha = 0
    }
    
    // Dismiss keyboard on tap gesture
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Move view up
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    // Move view down
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }

}

