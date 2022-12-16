//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    var pct: Float = 0.1
    var person: Int = 2
    var result: Float = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        if sender == zeroPctButton {
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            pct = 0.0
        } else if sender == tenPctButton {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            pct = 0.1
        } else {
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            pct = 0.2
        }
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        billTextField.endEditing(true)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let amount = Float(billTextField.text!)
        calculate(amount: amount!, percent: pct, number: Int(splitNumberLabel.text!)!)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    func calculate(amount: Float, percent: Float, number: Int) {
        let amountWithTip = amount * (1 + percent)
        result = amountWithTip / Float(number)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.total = String(format: "%.2f", result)
            destinationVC.settings = "Split between \(person) people\nWith \(String(format: "%.0f", pct * 100))% tip"
        }
    }
}

