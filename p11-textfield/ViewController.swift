//
//  ViewController.swift
//  p11-textfield
//
//  Created by Arjin Reyes on 3/28/19.
//  Copyright © 2019 Arjin Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textFieldView: TextFieldView?
    var errorMessage: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"

    override func loadView() {
        textFieldView = TextFieldView(fieldProperties: TextFieldViewProperties(),
                                      delegate: self)
        self.view = textFieldView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func emailValid(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let email = textField.text, !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else{
            textFieldView?.setState(state: .editing)
            return
        }
        if emailValid(candidate: email) {
            textFieldView?.setState(state: .editingSuccess)
        } else {
            textFieldView?.setState(state: .editingError(error: self.errorMessage))
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        if emailValid(candidate: newString) {
            textFieldView?.setState(state: .editingSuccess)
        } else {
            textFieldView?.setState(state: .editing)
        }
        textField.text = newString
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        guard let email = textField.text, !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else{
            textFieldView?.setState(state: .empty)
            return true
        }
        if self.emailValid(candidate: email) {
            textFieldView?.setState(state: .filledSuccess)
        } else {
            textFieldView?.setState(state: .filledError(error: self.errorMessage))
        }
        return true
    }
}

