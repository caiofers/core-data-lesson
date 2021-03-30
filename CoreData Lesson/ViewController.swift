//
//  ViewController.swift
//  CoreData Lesson
//
//  Created by Caio Fernandes on 29/03/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //savingDate(context: context)
        gettingData(context: context)
    }
    
    func gettingData(context: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        do {
            let products =  try context.fetch(request)
            
            if products.count > 0 {
                for product in products as! [NSManagedObject] {
                    if let description = product.value(forKey: "prod_description") {
                        print(description)
                    }
                    if let price = product.value(forKey: "prod_price") {
                        print(price)
                    }
                    if let color = product.value(forKey: "prod_color") {
                        print(color)
                    }
                }
            } else {
                print("Sem produtos cadastrados")
            }
        } catch {
            print("Faiô")
        }
    }
    
    func savingDate(context: NSManagedObjectContext) {
        
        // Criando entidade
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
        
        
        // Configurando objeto
        product.setValue("Cellphone", forKey: "prod_description")
        product.setValue(1199.99, forKey: "prod_price")
        product.setValue("pale blue sky", forKey: "prod_color")
        
        do {
            try context.save()
        } catch {
            print("Faiô")
        }
    }
    
}

