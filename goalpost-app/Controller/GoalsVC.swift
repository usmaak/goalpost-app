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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.cellForRow(at: indexPath) as! GoalCell
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.deletedGoal = self.goals[indexPath.row]
            self.showHideUndoView(viewIsVisible: true)
            
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when){
                // your code with delay
                self.showHideUndoView(viewIsVisible: false)
            }
            
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)

        if cell.completionView.isHidden {
            let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
                self.setProgress(atIndexPath: indexPath)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
            
            return [deleteAction, addAction]
        }
        else {
            return [deleteAction]
        }
    }
}

extension GoalsVC {
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
            print("Successfully fetched data")
        }
        catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}

        managedContext.undoManager = UndoManager()
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal.")
        }
        catch {
            debugPrint("Could not delete: \(error.localizedDescription)")
        }
    }
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}

        let chosenGoal = goals[indexPath.row]

        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress += 1
            print("Successfully set progress.")
        }
        else {
            return
        }
        
        do {
            try managedContext.save()
        }
        catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    func undoDeletion() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.undoManager?.undo()
        
        showHideUndoView(viewIsVisible: false)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func showHideUndoView(viewIsVisible visible: Bool) {
        if visible {
            self.undoViewHeightConstraint.constant = 50
        }
        else {
            undoViewHeightConstraint.constant = 0
        }
    }
}

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var undoViewHeightConstraint: NSLayoutConstraint!
    
    var goals: [Goal] = []
    var deletedGoal: Goal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        
        showHideUndoView(viewIsVisible: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if goals.count >= 1 {
                tableView.isHidden = false
            }
            else {
                tableView.isHidden = true
            }
        }

    }
    
    @IBAction func addGoalButtonWasPressed(_ sender: UIButton) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
    @IBAction func undoButtonWasPressed(_ sender: UIButton) {
        undoDeletion()
    }
}

