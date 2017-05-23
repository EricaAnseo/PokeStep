//
//  PokedexController.swift
//  PokeStep
//
//  Created by 20063209 on 05/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {

    var pokedex = [[String:Any]]()
    var pokemonID = [String]()
    var pokemonNames = [String]()
    var pokemonImages = [UIImage]()
    var pokemonType = [String]()
    var pokemonEvolution = [String]()
    var pokemonCandy = [Int]()
    var pokemonDistance = [Int]()
    
    var selectedPokemon: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readPokemonJson()
        
        
        //changing the colour of the navigation controller to match the background
        self.navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)]

    }
    
    //tells you which UICollectionView cell has been chosen
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         var currentPokemonNumber = 001
         var currentPokemonName = "Bulbasaur"
         var currentPokemonImage: UIImage!
         var currentCandyEvolveOne: Int = 25
         var currentCandyEvolveTwo: Int  = 100
         var currentTotalPokemonCandy: Int = 0
         var currentRequiredPokemonCandy: Int = 0
         var currentPokemonDistance = 3
         var testUserCurrentCandy = 5
         */
        
        selectedPokemon = indexPath[1]
        let singlePokemonViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
        
        let viewTitle = pokemonID[selectedPokemon] + " " + pokemonNames[selectedPokemon].uppercased()
        
        //Passing the data to the PokemonViewController
        singlePokemonViewController.currentPokemonNumber = pokemonID[selectedPokemon]
        singlePokemonViewController.currentPokemonImage = pokemonImages[selectedPokemon]
        singlePokemonViewController.currentPokemonName = pokemonNames[selectedPokemon]
        singlePokemonViewController.currentPokemonDistance = pokemonDistance[selectedPokemon]
        singlePokemonViewController.currentPokemonType = pokemonType[selectedPokemon]
        
        singlePokemonViewController.title = viewTitle

        
        
        //Changes the View after the cell has been selected
        navigationController?.pushViewController(singlePokemonViewController, animated: true)

    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonNames.count
        //return pokemonPictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemon", for: indexPath) as UICollectionViewCell

        //Tagged assigned in storyboard. Tag 1 is assigned to the UIimage
        let pokemonImage = pokemon.viewWithTag(1) as! UIImageView
        
        //Tag 2 is assigned to the UILabel which displays the name
        let pokemonName = pokemon.viewWithTag(2) as! UILabel
        
        pokemonImage.image = pokemonImages[indexPath.row]

        pokemonName.text = pokemonNames[indexPath.row]
        
        return pokemon
    }
    
    
    
    private func readPokemonJson()  {

        do {
            //if a json file called pokedex exists
            if let file = Bundle.main.url(forResource: "pokedex", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let pokedex = json as? [String: Any] {
                    
                    let pocketMonsters = pokedex["pokemon"] as? [[String: AnyObject]]
                    
                    for pokemon in pocketMonsters!{
                        
                        //Pokemon ID
                        if let id = pokemon["num"] as? String {
                            pokemonID.append(id)
                        }else { break }
                        
                        //Pokemon Name
                        if let name = pokemon["name"] as? String {
                            pokemonNames.append(name)
                        }else { break }
                        
                        //Pokemon Image
                        if let imageURL = pokemon["img"] as? String {
                            
                            let myImage = try UIImage(data: NSData(contentsOf: NSURL(string:imageURL) as! URL) as Data)
                            self.pokemonImages.append(myImage!)
                            
                        } else { break }
                        
                        //Pokemon Type - Rework for two or one Pokemon Types
                        if let type = pokemon["type"] as? [String] {
                            var pokemonTypesCombined: String = ""
                            
                            for pokeeType in type {
                                pokemonTypesCombined.append(pokeeType + " ")
                            }
                            
                            pokemonType.append(pokemonTypesCombined)
                            
                        }else {
                            pokemonType.append("N/A")
                        }
                        
                        //Pokemon Evolution - Rework for two or one Pokemon Types
                        if let nextEvolution = pokemon["next_evolution"] as? [String: String] {
                            let evolutionNumber = nextEvolution["num"]
                            pokemonEvolution.append(evolutionNumber!)
                            //for pokemonEvolve in nextEvolution {
                                
                                //print(pokemonEvolve)
                                //if let nextPokemonEvolve = nextEvolution["name"] as? String
                                //{
                                //    pokemonEvolution.append(nextPokemonEvolve)
                                //}
                               
                            //}
                        }else {
                            pokemonEvolution.append("N/A")
                        }

                        //Pokemon Candy
                        if let pokemonSweets = pokemon["candy_count"] as? Int
                        {
                            pokemonCandy.append(pokemonSweets)
                        }else {}
                        
                        //Pokemon Distance per Candy
                        if let pokemonKM = pokemon["distance"] as? Int
                        {
                            pokemonDistance.append(pokemonKM)
                        }else {}
                     
                    } //For each Pokemon
                    
                    //print(pokemonDistance)
                    
                } else if let object = json as? [String: Any] {
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
        }//end of catch
        
    }//end of func readPokemonJson
    
}//end of class
