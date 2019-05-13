//
//  ViewController.swift
//  CodingPlayground
//
//  Created by Raphael Berendes on 13.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import CoreData
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupModel()
    }

    func setupModel() {
        
        let duck = Toy(price: 3.99)
        let gameboy = Toy(price: 51.50)
        
        let peter = Kid(name: "Peter", age: 12, toys: nil)
        let mike = Kid(name: "Mike", age: 8, toys: [duck, gameboy])
        
        let eva = Mother(name: "Eva", age: nil, children: [peter, mike])
        
        do {
            let data = try JSONEncoder().encode(eva)
            createFamily(with: data)
        } catch {
            print(error)
        }
    }
    
    func createFamily(with motherData: Data) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let family = Family(entity: Family.entity(), insertInto: context)
        family.mother = motherData
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    @IBAction func showFamily(_ sender: UIButton) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Family>(entityName: "Family")
        do {
            let fetchResult = try context.fetch(fetchRequest)
            print(fetchResult)
            
            for result in fetchResult {
                guard let data = result.mother else { return }
                let mother = try JSONDecoder().decode(Mother.self, from: data)
                print(mother)
            }
            
        } catch {
            print(error)
        }
    }
    
}

