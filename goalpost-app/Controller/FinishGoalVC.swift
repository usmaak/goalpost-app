//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Scott Kilbourn on 11/23/17.
//  Copyright © 2017 Scott Kilbourn. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var createGoalButton: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    private var goalDescription: String!
    private var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalButton.bindToKeyboard()
        pointsTextField.delegate = self
    }

    func initData(goalDescription: String, goalType: GoalType) {
        self.goalDescription = goalDescription
        self.goalType = goalType
    }
    
    @IBAction func createGoalButtonWasPressed(_ sender: UIButton) {
        //Pass data into core data model.
    }
}
