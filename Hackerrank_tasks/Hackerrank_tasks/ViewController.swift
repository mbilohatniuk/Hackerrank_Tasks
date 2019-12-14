//
//  ViewController.swift
//  Hackerrank_tasks
//
//  Created by Maksym Bilohatniuk on 12/14/19.
//  Copyright © 2019 Maksym Bilohatniuk. All rights reserved.
//

import UIKit

enum Result {
    
    case notEnoughCharacters
    case nothingEntered
    case notContainNubmer
    case notContainLowercaseCharacter
    case notContainUppercaseCharacter
    case notContainSpecialCharacter
    case successfulRegistration
    
    var description: String {
        
        switch self {
        case .notEnoughCharacters:
            return "not enough characters"
        case .nothingEntered:
            return "Nothing Entered"
        case .notContainNubmer:
            return "Not contain number"
        case .notContainLowercaseCharacter:
            return "Not contain lower case character"
        case .notContainUppercaseCharacter:
            return "Not contain upper case character"
        case .notContainSpecialCharacter:
            return "Not contain special case character"
        case .successfulRegistration:
            return "Successful registration"
        }
    }
}



class ViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    
   
    
    private func checkText(limitNumber: Int) {
        
        guard let password = passwordTF.text else {
            showAlert(message: Result.nothingEntered)
            return
        }
        
        guard checkNumberOfCharacters(password,limitNumber) else {
            showAlert(message: Result.notEnoughCharacters)
            return
        }
        guard isContainNumber(password) else {
            showAlert(message: Result.notContainNubmer)
            return
        }
        guard isContainLowercaseCharacter(password: password) else {
            showAlert(message: Result.notContainLowercaseCharacter)
            return
        }
        guard isContainUpperCharacter(password: password) else {
            showAlert(message: Result.notContainUppercaseCharacter)
            return
        }
        guard isContainSpecialCharacter(password: password) else {
            showAlert(message: Result.notContainSpecialCharacter)
            return
        }
        showAlert(message: Result.successfulRegistration)
        
    }
    
    private func checkNumberOfCharacters(_ password: String, _ limitNumber: Int) -> Bool {
        
        guard password.count >= limitNumber else {
            showAlert(message: Result.notEnoughCharacters)
            return false
        }
        return true
    }
    
    private func isContainNumber(_ password: String) -> Bool {
        let numbers = "0123456789"
        var flag = false
        
        for item in numbers {
            if password.contains(item) {
                flag = true
                break
            }
        }
        return flag
    }
    
    private func isContainLowercaseCharacter(password: String ) -> Bool {
        let lowerCase = "abcdefghijklmnopqrstuvwxyz"
        var flag = false
        
        for item in lowerCase {
            if password.contains(item) {
                flag = true
                break
            }
        }
        return flag
    }
    
    private func isContainUpperCharacter(password: String ) -> Bool {
        let lowerCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var flag = false
        
        for item in lowerCase {
            if password.contains(item) {
                flag = true
                break
            }
        }
        return flag
    }
    
    private func isContainSpecialCharacter(password: String ) -> Bool {
        let lowerCase = "!@#$%^&*()-+"
        var flag = false
        
        for item in lowerCase {
            if password.contains(item) {
                flag = true
                break
            }
        }
        return flag
    }
    
    private func showAlert(message: Result) {

        let alert = UIAlertController(title: "Info", message: message.description, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func submitTaped(_ sender: UIButton) {
        checkText(limitNumber: 6)
    }
}

