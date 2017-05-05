//
//  ViewController.swift
//  PokeStep
//
//  Created by 20063209 on 05/04/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonCandy: UILabel!
    @IBOutlet weak var pokemonDistance: UILabel!
    @IBOutlet weak var userCurrentCandy: UITextField!
    @IBOutlet weak var distanceToWalk: UILabel!

    var currentPokemonNumber = "001"
    var currentPokemonName = "Bulbasaur"
    var currentCandyEvolveOne: Int = 25
    var currentCandyEvolveTwo: Int  = 100
    var currentTotalPokemonCandy: Int = 0
    var currentRequiredPokemonCandy: Int = 0
    var currentPokemonDistance = 3
    var testUserCurrentCandy = 5
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss Keyboard when the outside of the keyboard the outside of the keyboard is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        userCurrentCandy.delegate = self

        
        readJson()
        
        pokemonNumber.text = currentPokemonNumber
        
        //assigns uppercase version of text to the label
        pokemonName.text = currentPokemonName.uppercased()
        
        currentTotalPokemonCandy = currentCandyEvolveOne + currentCandyEvolveTwo
        pokemonCandy.text = String (currentTotalPokemonCandy)
        
        pokemonDistance.text = String (currentPokemonDistance)
        
        currentRequiredPokemonCandy = currentTotalPokemonCandy - testUserCurrentCandy
        
        distanceToWalk.text = String (currentRequiredPokemonCandy*currentPokemonDistance) + "KM"
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //dismisses the Keyboard on touch
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    private func readJson() {
        do {
            //if a json file called pokedex exists
            if let file = Bundle.main.url(forResource: "pokedex", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    
                    //testing code
                    if (object["pokemon"] as? [String: Any]) != nil {
                        print(object["pokemon"])
                    }
                    
                    // json is a dictionary
                    //print(object)
                    
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

