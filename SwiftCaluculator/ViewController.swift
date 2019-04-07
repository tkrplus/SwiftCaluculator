//
//  ViewController.swift
//  SwiftCaluculator
//
//  Created by 丹羽健 on 2019/04/02.
//  Copyright © 2019 Niwa. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {

    @IBOutlet weak var formulaLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
  
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var doubleZeroButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multipleButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        setupView()
    }
  
    func setupView() {
        formulaLabel.text = ""
        answerLabel.text = ""
        let radius = zeroButton.frame.width / 2.0
        zeroButton.layer.cornerRadius = radius
        doubleZeroButton.layer.cornerRadius = radius
        dotButton.layer.cornerRadius = radius
        oneButton.layer.cornerRadius = radius
        twoButton.layer.cornerRadius = radius
        threeButton.layer.cornerRadius = radius
        fourButton.layer.cornerRadius = radius
        fiveButton.layer.cornerRadius = radius
        sixButton.layer.cornerRadius = radius
        sevenButton.layer.cornerRadius = radius
        eightButton.layer.cornerRadius = radius
        nineButton.layer.cornerRadius = radius
        divideButton.layer.cornerRadius = radius
        multipleButton.layer.cornerRadius = radius
        minusButton.layer.cornerRadius = radius
        plusButton.layer.cornerRadius = radius
        clearButton.layer.cornerRadius = radius
        deleteButton.layer.cornerRadius = radius
        equalButton.layer.cornerRadius = radius
    }
    
    @IBAction func inputFormula(_ sender: UIButton) {
        let pattern:String = "[÷×\\+\\-\\.]"
        
        guard var formulaText:String = formulaLabel.text else {
        return
        }

        guard let senderedText:String = sender.titleLabel?.text else {
        return
        }
        
        let lastText:String = String(formulaText.last ?? " ")
        
        if( lastText.range(of: pattern, options: .regularExpression, range: nil) != nil &&
            senderedText.range(of: pattern, options: .regularExpression, range: nil) != nil
            ) {
            formulaText = String(formulaText.dropLast())
        }
        
        formulaLabel.text = formulaText + senderedText
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        formulaLabel.text = ""
        answerLabel.text = ""
    }
    
    @IBAction func deleteFormula(_ sender: Any) {
        guard let formulaText:String = formulaLabel.text else {
            return
        }
        
        formulaLabel.text = String(formulaText.dropLast())
        answerLabel.text = ""
    }
    
    @IBAction func calculateAnswer(_ sender: UIButton) {
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
    }
    
    private func formatFormula(_ formula: String) -> String {
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    private func evalFormula(_ formula: String) -> String {
        do {
            // Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            // 計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
    
    private func formatAnswer(_ answer: String) -> String {
        // 答えの小数点以下が`.0`だった場合は、`.0`を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
    
}

