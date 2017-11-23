//
//  ViewController.swift
//  goalpost-app
//
//  Created by Scott Kilbourn on 11/21/17.
//  Copyright © 2017 Scott Kilbourn. All rights reserved.
//

import UIKit
import CoreData

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        
        cell.configureCell(description: "Eat Cookies", type: .shortTerm, goalProgressAmount: 2)
        
        return cell
    }
}

class GoalsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
}

