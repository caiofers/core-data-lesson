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
    }
    
    func gettingData(context: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let users = try context.fetch(request)
            
            if users.count > 0 {
                for user in users as! [NSManagedObject]{
                    if let userName = user.value(forKey: "name") {
                        print(userName)
                    }
                }
            } else {
                print("Sem usuário bicho")
            }
            
        } catch {
            print("Faiô bicho")
        }
    }

    func savingData(context: NSManagedObjectContext) {
        // Criando entidade
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        // Configurando o objeto
        user.setValue("Bastião", forKey: "name")
        user.setValue(41, forKey: "age")
        user.setValue("boibrabo", forKey: "username")
        user.setValue("1234", forKey: "password")
        
        
        // Pesistir os dados
        
        do {
            try context.save()
            print ("Salvô")
        } catch {
            print("Faiô bicho")
        }
    }
}

