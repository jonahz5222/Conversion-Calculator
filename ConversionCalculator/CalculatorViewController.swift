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
    
    let converterArray = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                          Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                          Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
                          Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")]
    
    let actionSheet = UIAlertController(title: "Choose Converter", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputDisplay.text = converterArray[0].outputUnit
        inputDisplay.text = converterArray[0].inputUnit
        
        for converter in converterArray {
            actionSheet.addAction(UIAlertAction(title: converter.label, style: .default, handler: { (_) in
                self.outputDisplay.text = converter.outputUnit
                self.inputDisplay.text = converter.inputUnit
            }))
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleConvert(_ sender: Any) {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Converter {
    let label:String
    let inputUnit:String
    let outputUnit:String
}
