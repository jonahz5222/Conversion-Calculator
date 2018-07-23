//
//  CalculatorViewController.swift
//  ConversionCalculator
//
//  Created by Jonah Zukosky on 7/12/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    var numberToBeConverted: String = ""
    var inputIsNegative = false
    var decimalIsPresent = false
    
    var currentConverter: Converter = Converter(label: ConverterType.fToC, inputUnit: "°F", outputUnit: "°C")
    
    let converterArray = [Converter(label: ConverterType.fToC, inputUnit: "°F", outputUnit: "°C"),
                          Converter(label: ConverterType.cToF, inputUnit: "°C", outputUnit: "°F"),
                          Converter(label: ConverterType.miToKm, inputUnit: "mi", outputUnit: "km"),
                          Converter(label: ConverterType.kmToMi, inputUnit: "km", outputUnit: "mi")]
    
    let actionSheet = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputDisplay.text = converterArray[0].outputUnit
        inputDisplay.text = converterArray[0].inputUnit
        
        for converter in converterArray {
            actionSheet.addAction(UIAlertAction(title: converter.label.rawValue, style: .default, handler: { (_) in
                self.currentConverter = converter
                self.updateInputField()
            }))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleConvert(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func handleClear(_ sender: Any) {
        outputDisplay.text = currentConverter.outputUnit
        numberToBeConverted = ""
        updateInputField()
    }
    
    @IBAction func handleSignSwitch(_ sender: Any) {
        if !numberToBeConverted.isEmpty {
            if !inputIsNegative {
                inputIsNegative = true
                numberToBeConverted = "-" + numberToBeConverted
            }else {
                inputIsNegative = false
                numberToBeConverted.remove(at: numberToBeConverted.startIndex)
            }
            updateInputField()
        }
    }
    
    @IBAction func handleDecimal(_ sender: Any) {
        if decimalIsPresent {
            return
        }
        numberToBeConverted += "."
        decimalIsPresent = true
        updateInputField()
    }
    
    @IBAction func handleInput(_ sender: UIButton) {
        numberToBeConverted += String(sender.tag)
        updateInputField()
    }
    
    func updateInputField() {
        inputDisplay.text = numberToBeConverted + " " + currentConverter.inputUnit
        convert()
    }
    
    func convert() {
        guard let input = Double(numberToBeConverted) else {
            return
        }
        var output:Double? = nil
        
        switch currentConverter.label {
        case .fToC:
            output = (input - 32) * 5/9
        case .cToF:
            output = (input * 9/5) + 32
        case .miToKm:
            output = (input / 0.62137)
        case .kmToMi:
            output = (input * 0.62137)
        }
        
        outputDisplay.text = String(format: "%.2f", output!) + " " + currentConverter.outputUnit
    }
}

struct Converter {
    let label:ConverterType
    let inputUnit:String
    let outputUnit:String
}

enum ConverterType: String {
    case cToF = "celsius to fahrenheit"
    case fToC = "fahrenheit to celsius"
    case kmToMi = "kilometers to miles"
    case miToKm = "miles to kilometers"
}
