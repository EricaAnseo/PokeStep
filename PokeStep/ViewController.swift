//
//  ViewController.swift
//  PokeStep
//
//  Created by 20063209 on 05/04/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readJson()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func readJson() {
        do {
            //if a json file called pokedex exists
            if let file = Bundle.main.url(forResource: "pokedex", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*private func callPokemonByNumber()
    {
        do{
            //updated by xcode, if the json file is not null
            if let file = Bundle.main.url(forResource: "pokedex", withExtension: "json")  {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                
                /*if let dictionary = jsonWithObjectRoot as? [String: Any] {
                    if let number = dictionary["someKey"] as? Double {
                        // access individual value in dictionary
                    }
                    
                    for (key, value) in dictionary {
                        // access all key / value pairs in dictionary
                    }
                    
                    if let nestedDictionary = dictionary["anotherKey"] as? [String: Any] {
                        // access nested dictionary values by key
                    }
                }*/
                
                
            }

        }
            
        //handles any errors that may occur from reading the json file
        catch {
            print(error.localizedDescription)
        }
        
    } */


}

