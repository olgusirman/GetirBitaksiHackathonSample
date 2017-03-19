//
//  PudraScrollView.swift
//  ScrollViewCosntraintExample
//
//  Created by Olgu Sirman on 24/02/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import UIKit

class PDScrollView: UIScrollView {

//    var bottomConstraint : NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(PDScrollView.adjustForKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(PDScrollView.adjustForKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        /*
        for constraint in constraints {
            
            if constraint.identifier == "bottomSubviewConstraint" {
                bottomConstraint = constraint
                break
            }
            
            if constraint.identifier == "bottomSuperConstraint" {
                bottomConstraint = constraint
                break
            }
            
        }
        */
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func adjustForKeyboard(_ notification: Notification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        guard let keyboardViewEndFrame = superview?.convert(keyboardScreenEndFrame, from: superview?.window) else { print("keyboardViewEndFrame"); return }
        
        let keyboardHeight = keyboardViewEndFrame.height
        
        if notification.name == NSNotification.Name.UIKeyboardWillHide {
            
            self.contentInset = UIEdgeInsets.zero
            //self.superview?.frame.origin.y -= keyboardViewEndFrame.height
            //self.frame.origin.y = 0
            
//            bottomConstraint?.constant = 0
//            self.layoutIfNeeded()
            
        } else {
            
//            bottomConstraint?.constant = keyboardHeight
//            self.layoutIfNeeded()

            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            
//            if self.superview?.frame.origin.y == 0 {
            //        self.frame.origin.y -= keyboardHeight
//                })
//            }
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
}
