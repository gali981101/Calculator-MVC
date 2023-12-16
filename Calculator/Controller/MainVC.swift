//
//  ViewController.swift
//  Calculator
//
//  Created by Terry Jason on 2023/12/15.
//

import UIKit

class MainVC: UIViewController {
    
    private lazy var isFinishedTyping: Bool = true
    private lazy var storedValue: String = ""
    
    private lazy var calculator = Calculator()
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    
    private var displayNumber: Double {
        get {
            guard let text = displayLabel.text, let number = Double(text) else { fatalError("無法轉換成 Double") }
            return number
        }
        set {
            displayLabel.text = newValue == 0.0 ? "0" : roundingDisplay(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTyping = true
        storedValue = ""
        
        guard let calcSign = sender.currentTitle else { return }
        if calcSign == "C" { acButton.setTitle("AC", for: .normal) }
        
        calculator.setNumber(displayNumber) 
        
        if let value = calculator.calculate(of: calcSign) {
            displayNumber = value
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        guard let numText = sender.currentTitle else { return }
        dealWithNumber(of: numText)
        acButton.setTitle("C", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - String Manipulate

extension MainVC {
    
    private func roundingDisplay(_ value: Double) -> String {
        if value == floor(value) { return String(floor(value)) }
        return String(value)
    }
    
    private func dealWithNumber(of numText: String) {
        guard displayLabel.text != nil else { return }
        
        if isFinishedTyping {
            dealWithFirstDot(of: numText)
            isFinishedTyping = false
        } else {
            if numText == "." && storedValue.contains(".") { return }
            displayLabel.text! += numText
            storedValue.append(numText)
        }
    }
    
    private func dealWithFirstDot(of numText: String) {
        if displayLabel.text == "0" && numText == "." {
            displayLabel.text! += numText
            storedValue.append(numText)
        } else {
            displayLabel.text = numText
        }
    }
    
}





