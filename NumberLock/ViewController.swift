//
//  ViewController.swift
//  NumberLock
//
//  Created by Yu-KaiChao on 2018-12-28.
//  Copyright © 2018 Yu-KaiChao. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    //make a random number
    //nextInt(upperBound: 100) only show 0 - 99, so we need +1 (1 - 100)
    var answer = GKRandomSource.sharedRandom().nextInt(upperBound: 300) + 1
    var maxNumber = 300
    var minNumber = 1
    var chanceNumber = 8
    var isOver = false
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var Chance: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBAction func makeAGuess(_ sender: UIButton) {
        if isOver == false{
            //playing game
            print("Answer = \(answer)")
            
            //check input text
            let inputText = inputTextField.text!
            
            //clear text field
            inputTextField.text = ""
            
            print("inputText = \(inputText)")
            
            let inputNumber = Int(inputText)
            
            if inputNumber == nil{
                //invalid input
                messageLabel.text = "Invalid input.\n Please try to guess between \(minNumber)~\(maxNumber)"
            }else{
                //valid input
                if inputNumber! > maxNumber || inputNumber! < minNumber{
                    messageLabel.text = "Out of the range!\n Please try to guess between \(minNumber)~\(maxNumber)"
                    chanceNumber-=1
                    Chance.text = "Chance: \(chanceNumber)"
                }else if inputNumber! == answer{
                    //Right answer
                    messageLabel.text = "NICE! You unlocked it! The answer is \(answer).\n Press [Guess] to play again."
                    isOver = true
                    //"finish image" have been changed
                    background.image = UIImage(named: "Finish")
                }else{
                    //Wrong answer
                    if inputNumber! > answer{
                        //larger than answer
                        maxNumber = inputNumber!
                        messageLabel.text = "Too big! Try to guess between \(minNumber)~\(maxNumber)"
                        chanceNumber-=1
                        Chance.text = "Chance: \(chanceNumber)"
                    }else{
                        //smaller than answer
                        minNumber = inputNumber!
                        messageLabel.text = "Too small! Try to guess between \(minNumber)~\(maxNumber)"
                        chanceNumber-=1
                        Chance.text = "Chance: \(chanceNumber)"
                    }
                }
                if chanceNumber == 0{
                    messageLabel.text = "Sorry! You did not unlocked it!\n The answer is \(answer).\n Press [Guess] to play again."
                    isOver = true
                }
            }
        }else{
            //game is over
            //reset the whole game
            minNumber = 0
            maxNumber = 300
            chanceNumber = 8
            messageLabel.text = "Guess a number between \(minNumber)~\(maxNumber)"
            Chance.text = "Chance: \(chanceNumber)"
            answer = GKRandomSource.sharedRandom().nextInt(upperBound: 300) + 1
            isOver = false
            background.image = UIImage(named: "BG")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show the keyboard first
        inputTextField.becomeFirstResponder()
        
    }


}

