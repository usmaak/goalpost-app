//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Scott Kilbourn on 11/23/17.
//  Copyright © 2017 Scott Kilbourn. All rights reserved.
//

import UIKit
import CoreData

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
        if pointsTextField.text != nil {
            self.save { (complete) in
                if complete {
                    
                }
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = 0
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        }
        catch {
            debugPrint("Could not save: \(error)")
            completion(false)
        }
    }
    
    @IBAction func backButtonWasPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
