//
//  ViewController.swift
//  Replace
//
//  Created by Стас Бойко on 19.08.2022.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var findTextField: UITextField!
    @IBOutlet weak var replaceWithTextField: UITextField!

    @IBOutlet weak var inputTextField: UITextView!
    @IBOutlet weak var replaceButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputTextField.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0).cgColor
        inputTextField.layer.borderWidth = 0.5
        inputTextField.layer.cornerRadius = 5
        replaceButton.layer.cornerRadius = 24
    }


    @IBAction func replaceButtonPressed(_ sender: Any) {
        if checkFields() {
            replaceText()
        }
    }
    
    private func checkFields() -> Bool {
        guard let find = findTextField.text else { return false }
        guard let replace = replaceWithTextField.text else { return false }
        guard let text = inputTextField.text else { return false }
        
        
        if find.isEmpty {
            resultLabel.text = "Choose word to replace\n"
            return false
        }
        if replace.isEmpty {
            resultLabel.text = "Decide with which word replace \"\(findTextField?.text ?? "")\"\n"
          return false
        }
        if text.isEmpty {
            resultLabel.text = "Input text field cann`t be empty!\n"
           return false
        }
        
        return true
        
    }
            
    
    private func replaceText() {
        guard let find = findTextField.text else { return }
        guard let replace = replaceWithTextField.text else { return }
        guard let text = inputTextField.text else { return }
        
        var resultText = text.replacingOccurrences(of: find, with: replace, options: .caseInsensitive)
        
        let pattern = "((\\.\\n|\\.|\\?|\\!)(\\s)+[a-z])"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: resultText, range: NSRange(location: 0, length: text.count))

        let result = matches.map({
            String(resultText[Range($0.range, in: text)!])
        })

        result.forEach { match in
            resultText = resultText.replacingOccurrences(of: match, with: match.uppercased())
        }

        resultLabel.text = resultText
    }
}
    
    
    


