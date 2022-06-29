//
//  FirstTableViewController.swift
//  MyCostsTestWithCoreData
//
//  Created by Анна Тибекина on 22.06.2022.
//

import UIKit
import CoreData

class FirstTableViewController: UITableViewController {
  
    
    struct Constants{
        static let entity = "TestCost"
        static let sortName = "arrayLabel"
        static let cellName = "cell"
        static let identifire = "tableInAddVC"
    }
    
   
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fatchResult = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let sortDescription = NSSortDescriptor(key: Constants.sortName, ascending: true)
        fatchResult.sortDescriptors = [sortDescription]
        let fetcResultController = NSFetchedResultsController(fetchRequest: fatchResult, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetcResultController
    }()
    
    override func viewDidLoad() {
        fetchResultController.delegate = self
        super.viewDidLoad()
        do{
            try fetchResultController.performFetch()
        }catch{
            print(error)
            
        }
       // Удаляем разлиновку пустых ячеек
        tableView.tableFooterView = UIView()
        //Большой заголовок
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return fetchResultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        let testCost = fetchResultController.object(at: indexPath) as! TestCost
        cell.textLabel?.text = testCost.arrayLabel
        cell.detailTextLabel?.text = testCost.arrayTextField
     

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testCost = fetchResultController.object(at: indexPath) as! TestCost
        performSegue(withIdentifier: Constants.identifire, sender: testCost)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let testCost = fetchResultController.object(at: indexPath) as! TestCost
            CoreDataManager.instance.context.delete(testCost)
            CoreDataManager.instance.saveContext()
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.identifire{
            let controller = segue.destination as! MyViewController
            controller.testCost = sender as? TestCost
        }
    }
    
    
}

extension FirstTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let testCost = fetchResultController.object(at: indexPath) as! TestCost
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = testCost.arrayLabel
                cell?.detailTextLabel?.text = testCost.arrayTextField
            }
        default:
            break
        }
    }
    
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
