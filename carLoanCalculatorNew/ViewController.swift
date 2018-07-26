//
//  ViewController.swift
//  carLoanCalculatorNew
//
//  Created by Emanuel Zapata on 4/12/18.
//  Copyright © 2018 Emanuel Zapata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var SPBox: UITextField!
    @IBOutlet weak var TIVBox: UITextField!
    @IBOutlet weak var TIPBox: UITextField!
    @IBOutlet weak var STBox: UITextField!
    @IBOutlet weak var IRBox: UITextField!
    @IBOutlet weak var DPBox: UITextField!
    @IBOutlet weak var TIMBox: UITextField!
    @IBOutlet weak var EFBox: UITextField!
    @IBOutlet weak var paymentsLabel: UILabel!
    @IBOutlet weak var totalLoanAmountLabel: UILabel!
    @IBOutlet weak var salesTaxTotalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self.view, action: Selector("endEditing:")))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func calculateButtonClicked(_ sender: Any) {
        var sellingPrice = Double(SPBox.text!)
        var tradeInValue = Double(TIVBox.text!)
        var balanceOwed = Double(TIPBox.text!)
        var stateTaxRate = Double(STBox.text!)
        var interestRate = Double(IRBox.text!)
        var downPayment = Double(DPBox.text!)
        var termInMonths = Double(TIMBox.text!)
        var extraFees = Double(EFBox.text!)
        var principalAmount = (sellingPrice! + (balanceOwed! - tradeInValue!) + extraFees!)-downPayment!
        var convertedInterestRate :Double = 0
        var finalInterestValue :Double = 0
        var finalCalcNumber :Double = 0
        var monthlyPayment :Double = 0
        var totalSalesTax :Double = 0
        
        //first thingis to calculate the sales tax to add to the total principal of the loan
        stateTaxRate = stateTaxRate!/100
        totalSalesTax = principalAmount * stateTaxRate!
        
        //add totalSalesTax to principalAmount to show its actual monthly payments more accurately since mose people add that to the loan as well
        principalAmount = principalAmount + totalSalesTax
        
        //step1
        //convert interest rate into decimal value by dividiny interest by 100
        convertedInterestRate = interestRate!/100
        
        //step2
        //divide converteInterestRate by 12 to give the final interestValue
        finalInterestValue = convertedInterestRate/12
        
        //step3
        //calculae the total principal amount then multiply that by finalinterestValue calculated from step2
        finalCalcNumber = finalInterestValue * principalAmount
        
        //step4
        //take finalInterestValue and add 1 to it
        finalInterestValue = finalInterestValue + 1
        
        //step5
        //take finalInterestValue as calculated in step 4 and raise it to the power of the number of months for the loan
        finalInterestValue = pow(finalInterestValue, termInMonths!)
        
        //step6
        //dividee 1 by the number gotten in finalInteresteValue in step 5, this can be rounded or not.
        finalInterestValue = 1/finalInterestValue
        //finalInterestValue = round(1000.0*finalInterestValue)/1000.0
        
        //step7
        //subtract this number from 1 to calculate final payments
        finalInterestValue = 1-finalInterestValue
        
        
        //step8
        //divide the number from step 3 by the number from step 7
        monthlyPayment = finalCalcNumber/finalInterestValue
        
        //final calculations not from calculating payments
        //total sales tax paid
        //stateTaxRate = stateTaxRate!/100
        //totalSalesTax = principalAmount * stateTaxRate!
        
        
        //display final results. PrincipalAmount of loan, sales tax amount, and monthly payments
        paymentsLabel.text = String(monthlyPayment)
        totalLoanAmountLabel.text = String(principalAmount)
        salesTaxTotalAmountLabel.text = String(totalSalesTax)
    }
    

}

