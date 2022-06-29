//
//  ViewController.swift
//  MyCostsTestWithCoreData
//
//  Created by Анна Тибекина on 22.06.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
   
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "TabBarST", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarST")
        self.navigationController?.pushViewController(vc, animated: true)
        
        // Извлекаем значение атрибута
        let manegedObject = TestCost()
    
        
        let arrayLabel =  manegedObject.arrayLabel
        let arrayTextField = manegedObject.arrayTextField
        //Сохранение данных
        CoreDataManager.instance.saveContext()
        
        //Извлекаем данные
        
        let fatchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TestCost")
        do{
            let result = try CoreDataManager.instance.context.fetch(fatchRequest)
            for res in result as! [TestCost]{
                print("\(res.arrayLabel), \(res.arrayTextField)")
            }
        } catch {
            print(error)
        }
    }


}

