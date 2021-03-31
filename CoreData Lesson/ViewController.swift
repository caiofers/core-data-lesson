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
        //gettingData(context: context)
        editingData(context: context)
    }
    
    func gettingData(context: NSManagedObjectContext) {
        
        // Criando requisição
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        // Criando ordenação
        let ordenedRequestDescription = NSSortDescriptor(key: "prod_description", ascending: false)
        let ordenedRequestPrice = NSSortDescriptor(key: "prod_price", ascending: true)
        
        // Aplicando ordenação à requisição
        request.sortDescriptors = [ordenedRequestDescription, ordenedRequestPrice]
        
        // Criando filtro
        //let predicate = NSPredicate(format: "prod_description == %@", "iMac 2018")
        //let predicate = NSPredicate(format: "prod_description contains %@", "iMac")
        //let predicate = NSPredicate(format: "prod_description contains [c] %@", "mac")
        //let predicate = NSPredicate(format: "prod_description beginswith [c] %@", "mac")
        //let predicate = NSPredicate(format: "prod_price >= %@", "1000")
        
        
        // Aplicando filtro
        //request.predicate = predicate
        
        
        // Filtros compostos
        let predicate1 = NSPredicate(format: "prod_description contains [c] %@", "mac")
        let predicate2 = NSPredicate(format: "prod_description contains %@", "2018")
        //let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate1, predicate2])
        request.predicate = compoundPredicate
        
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
        product.setValue("iMac 2018", forKey: "prod_description")
        product.setValue(1199.99, forKey: "prod_price")
        product.setValue("pale blue sky", forKey: "prod_color")
        
        do {
            try context.save()
        } catch {
            print("Faiô")
        }
    }
    
    func editingData(context: NSManagedObjectContext) {
        
        // Criando requisição
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        // Filtro
        let predicate = NSPredicate(format: "prod_description contains [c] %@", "imac")
        
        // Aplicando filtro
        request.predicate = predicate
        
        do {
            let products =  try context.fetch(request)
            
            if products.count > 0 {
                for product in products as! [NSManagedObject] {
                    product.setValue(12999.99, forKey: "prod_price")
                    do {
                        try context.save()
                    } catch {
                        print("Faiô")
                    }
                }
            } else {
                print("Sem produtos cadastrados")
            }
        } catch {
            print("Faiô")
        }
    }
}

