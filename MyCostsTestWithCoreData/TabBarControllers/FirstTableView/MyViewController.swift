//
//  MyViewController.swift
//  MyCostsTestWithCoreData
//
//  Created by Анна Тибекина on 22.06.2022.
//

import UIKit

class MyViewController: UIViewController {
    var testCost: TestCost?
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if saveCosts(){
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var textCostsName: UITextField!
    @IBOutlet weak var textCostSum: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let testCost = testCost {
            textCostsName.text = testCost.arrayLabel
            textCostSum.text = testCost.arrayTextField
            textCostsName.backgroundColor = UIColor.white
            textCostSum.backgroundColor = UIColor.white
        }
    }
    
    func saveCosts() -> Bool {
        if textCostSum.text!.isEmpty{
            let alert = UIAlertController(title: "Ошибка", message: "Введите сумму расходов", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        if testCost == nil{
            testCost = TestCost()
        }
        if let testCost = testCost {
            testCost.arrayLabel = textCostsName.text
            testCost.arrayTextField = textCostSum.text
            CoreDataManager.instance.saveContext()
        }
        return true
    }
    
    
    @IBAction func firstTFAction(_ sender: Any) {
   
    }
    @IBAction func secondTFAction(_ sender: Any) {
     
        
    }
    
}
