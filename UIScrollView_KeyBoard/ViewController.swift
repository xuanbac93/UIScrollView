//
//  ViewController.swift
//  UIScrollView_KeyBoard
//
//  Created by XuanBac on 9/5/17.
//  Copyright © 2017 XuanBac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //dismiss keyboard
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(dismiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification){
        //1
        let userInfo = sender.userInfo
        //2
        let keyboardSize: CGSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let offset: CGSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        //3
        if keyboardSize.height == offset.height{
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
            
        }
        else {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification){
        let userInfo = sender.userInfo!
        let keyboardSize: CGSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        self.view.frame.origin.y += keyboardSize.height
    }

}

