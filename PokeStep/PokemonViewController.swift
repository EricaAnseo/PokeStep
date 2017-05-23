//
//  ViewController.swift
//  PokeStep
//
//  Created by 20063209 on 05/04/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit
import Foundation

class PokemonViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonCandy: UILabel!
    @IBOutlet weak var pokemonDistance: UILabel!
    @IBOutlet weak var userCurrentCandy: UITextField!
    @IBOutlet weak var distanceToWalk: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!

    var currentPokemonNumber = 001
    var currentPokemonName = "Bulbasaur"
    var currentPokemonImage: UIImage!
    var currentCandyEvolveOne: Int = 25
    var currentCandyEvolveTwo: Int  = 100
    var currentTotalPokemonCandy: Int = 0
    var currentRequiredPokemonCandy: Int = 0
    var currentPokemonDistance = 3
    var testUserCurrentCandy = 5
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss Keyboard when the outside of the keyboard the outside of the keyboard is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(PokemonViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //changing the navigation controller to match the page background colour
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.89, green:1.00, blue:0.88, alpha:1.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.12, green:0.52, blue:0.59, alpha:1.0)]
        
        userCurrentCandy.delegate = self

        readJson()
        
        
        pokemonNumber.text = String (currentPokemonNumber)
        
        
        pokemonImage.image = currentPokemonImage
        
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
    
}

