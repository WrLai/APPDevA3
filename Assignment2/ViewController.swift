//
//  ViewController.swift
//  Assignment2 & 3
//
//
//I'm using two classes to store my quotes and timer.
//Currently previous button is disabled but the code is still here because it was from assignment 2. However, the alert feature when the quote is entered empty is still there.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, MyTimerDelegate {
    
    var initialTime = 5
    var x : Quotation?
    var myTimer = MyTimer()
    var timer = Timer()
    var quotationsAreHere = ["This is the first quotation","This isn't the third quotation","This is the third then"]
    var authorsAreHere = ["quote1","quote2","quote3"]
    
    var index = 0
   
    
    
    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var displayBoth: UILabel!
    @IBOutlet weak var delayLabel: UILabel!
    @IBOutlet weak var initialslider: UISlider!
    @IBOutlet weak var currentTimeLable: UILabel!
    
    //whenever it slides, it sends in a value and resets the timer immediately
    @IBAction func initialTimeSliderValueChanged(_ sender: UISlider) {
        //recasting sender value to int
        let iniTime = Int(sender.value)
        initialTime = iniTime
        print("from slider\(iniTime)")
        delayLabel.text = "Delay: \(iniTime)s"
        currentTimeLable.text = "Time left:\(iniTime)"
        myTimer.reset()
        myTimer.setInitialTime(iniTime)
        
    }
    
    //MyTimerDelegate methods
    func timeChanged(time: Int){
        currentTimeLable.text = "Time left: \(time)s"
    }

    //To add quotes and authors to the database
    @IBAction func addButtonForQuoteAndAuthor(_ sender: UIButton) {
        let quotes = quoteTextField.text
        let authors = authorTextField.text
        
        
        let quotestemp = Quotation.init(quotesdb: quotes!, authorsdb: authors!)
        if quotes!.isEmpty != true
        {
        if authors!.isEmpty == true{
            quotestemp.authorsdb = "Anonymous"
        }
        authorsAreHere.append(quotestemp.authorsdb)
        
        if quotes!.isEmpty == false {
            quotationsAreHere.append(quotestemp.quotesdb)
        }
        
        print(quotestemp.quotesdb, quotestemp.authorsdb)
        //not gonna need it for easy grading purpose.
//        displayBoth.text = " \"\(quotestemp.quotesdb)\",\(quotestemp.authorsdb)"
        }
        else{
            showAlert()
        }
        
        
        self.quoteTextField.text = nil
        self.authorTextField.text = nil
  
    }
    
    //Disabled currently, but works, it was connected to a next
    //button, whenever the button is pressed, it passes to the next
    //quote and author
    @IBAction func nextTappedButton(_ sender: UIButton) {
        if quotationsAreHere.isEmpty == false {
            index = (index + 1) % quotationsAreHere.count
            displayBoth.text = "\"\(quotationsAreHere[index])\",\(authorsAreHere[index])"
        }
    }
    
    //Disabled currently, it works the same as next button but
    //this one goes to the previous quote and author
    @IBAction func prevTappedButton(_ sender: UIButton) {
        //previous quote and author
        if quotationsAreHere.isEmpty == false {
            if index >= 1 {
                index = (index - 1 ) % quotationsAreHere.count
                displayBoth.text = "\"\(quotationsAreHere[index])\",\(authorsAreHere[index])"
            }
            else{
                index = quotationsAreHere.count
                index = (index - 1) % quotationsAreHere.count
                displayBoth.text = "\"\(quotationsAreHere[index])\",\(authorsAreHere[index])"

                
            }
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quoteTextField.delegate = self
        authorTextField.delegate = self
        myTimer.start()
        myTimer.delegate = self
        myTimer.setInitialTime(initialTime)
        initialslider.value = Float(initialTime)
        delayLabel.text = "Delay: \(initialTime)s"
        currentTimeLable.text = "Time left: \(initialTime)s"
        
        displayBoth.text = "\"\(quotationsAreHere[index])\", \(authorsAreHere[index])"
        
        
    }
    
    //Tap the screen, keyboard goes away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //Same as next button
    func nextQuote(){
        if quotationsAreHere.isEmpty == false {
            index = (index + 1) % quotationsAreHere.count
            displayBoth.text = "\"\(quotationsAreHere[index])\",\(authorsAreHere[index])"
        }
    }
    
    
    //Hit return, keyboard goes away
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    //User it when the user doesn't input
    func showAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please input a valid quote :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "If you say so...", style: .default, handler:nil))
        present(alert, animated: true)
    }

}

