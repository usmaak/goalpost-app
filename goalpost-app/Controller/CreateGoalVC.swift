//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Scott Kilbourn on 11/22/17.
//  Copyright © 2017 Scott Kilbourn. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermButton: UIButton!
    @IBOutlet weak var longTermButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButtonWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func shortTermButtonWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: UIButton) {
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        dismissDetail()
    }
    
}
