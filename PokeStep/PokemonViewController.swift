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
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonCandy: UILabel!
    @IBOutlet weak var pokemonDistance: UILabel!
    @IBOutlet weak var userCurrentCandy: UITextField!
    @IBOutlet weak var distanceToWalk: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var remainingCandyRequiredLabel: UILabel!
    @IBOutlet weak var evolutionStageOne: UIImageView!
    @IBOutlet weak var evolutionStageTwo: UIImageView!
    @IBOutlet weak var evolutionStageThree: UIImageView!
    @IBOutlet weak var secondEvolutionArrow: UIImageView!
    @IBOutlet weak var firstEvolutionArrow: UIImageView!
    
    //MARK: Attributes
    var currentPokemonNumber = "001"
    var currentPokemonName = "Bulbasaur"
    var currentPokemonImage: UIImage!
    var currentPokemonEvolutionStageOneImage: UIImage!
    var currentPokemonEvolutionStageTwoImage: UIImage!
    var currentPokemonEvolutionStageThreeImage: UIImage!
    var currentCandyEvolveOne: Int = 0
    var currentCandyEvolveTwo: Int  = 0
    var currentTotalPokemonCandy: Int = 0
    var currentRequiredPokemonCandy: Int = 0
    var currentPokemonDistance = 0
    var currentPokemonType = "Fighting/Fighting"
    var inputUserCurrentCandy = 0
    var evolutions = [String]()
    var noOfEvolutions = 0
    var noOfPreviousEvolutions = 0
    
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss Keyboard when the outside of the keyboard the outside of the keyboard is clicked
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(PokemonViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Assigning information to the UIImageView and UILabels
        userCurrentCandy.delegate = self
        userCurrentCandy.text = String (inputUserCurrentCandy)
        pokemonImage.image = currentPokemonImage
        evolutionStageOne.image = currentPokemonEvolutionStageOneImage
        evolutionStageTwo.image = currentPokemonEvolutionStageTwoImage
        evolutionStageThree.image = currentPokemonEvolutionStageThreeImage
        currentTotalPokemonCandy = currentCandyEvolveOne + currentCandyEvolveTwo
        pokemonCandy.text = String (currentTotalPokemonCandy)
        pokemonDistance.text = String (currentPokemonDistance)
        currentRequiredPokemonCandy = currentTotalPokemonCandy - inputUserCurrentCandy
        distanceToWalk.text = String (currentRequiredPokemonCandy*currentPokemonDistance) + "KM"
        pokemonTypeLabel.text = currentPokemonType
        
        checkEvolutionArrows()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Comment - Moves the UIView 
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -160, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -160, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.25
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    //dismisses the Keyboard on touch
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func checkEvolutionArrows()
    {
        //Based on the number of evolutions, show certain number of arrows
        if (noOfPreviousEvolutions == 0)
        {
            if (noOfEvolutions == 0)
            {
                firstEvolutionArrow.isHidden = true
                secondEvolutionArrow.isHidden = true
            }
                
            else if (noOfEvolutions == 1)
            {
                firstEvolutionArrow.isHidden = false
                secondEvolutionArrow.isHidden = true
                
            } else if (noOfEvolutions == 2)
            {
                firstEvolutionArrow.isHidden = false
                secondEvolutionArrow.isHidden = false
                
            } else {}
        }
            
        else if (noOfPreviousEvolutions == 1)
        {
            if (noOfEvolutions == 1)
            {
                firstEvolutionArrow.isHidden = false
                secondEvolutionArrow.isHidden = false
            }
            else if (noOfEvolutions == 0){
                firstEvolutionArrow.isHidden = false
                secondEvolutionArrow.isHidden = true
            } else {}
            
        } else  if (noOfPreviousEvolutions == 2){
            
            firstEvolutionArrow.isHidden = false
            secondEvolutionArrow.isHidden = false
            
        } else {
            
        }
    }
    
    //MARK: Actions
    @IBAction func calculateButton(_ sender: AnyObject) {
        currentRequiredPokemonCandy = (currentTotalPokemonCandy - Int(userCurrentCandy.text!)!)

        if (currentRequiredPokemonCandy <= 0)
        {
            remainingCandyRequiredLabel.text = "0"
            distanceToWalk.text = "0KM"
        }
        else
        {
            remainingCandyRequiredLabel.text = String(currentRequiredPokemonCandy)
            distanceToWalk.text = String (currentRequiredPokemonCandy*currentPokemonDistance) + "KM"
        }
        
        
        
    }

    
}

