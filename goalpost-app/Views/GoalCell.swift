//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Scott Kilbourn on 11/21/17.
//  Copyright © 2017 Scott Kilbourn. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var goalTypeLabel: UILabel!
    @IBOutlet weak var goalProgressLabel: UILabel!
 
    func configureCell(goal: Goal) {
        self.goalDescriptionLabel.text = goal.goalDescription
        self.goalTypeLabel.text = goal.goalType
        self.goalProgressLabel.text = String(describing: goal.goalProgress)
    }
}
