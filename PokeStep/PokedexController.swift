//
//  PokedexController.swift
//  PokeStep
//
//  Created by 20063209 on 05/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {

    //MARK: Attributes
    var pokedex = [[String:Any]]()
    var pokemonID = [String]()
    var pokemonNames = [String]()
    var pokemonImages = [UIImage]()
    var pokemonType = [String]()
    var pokemonEvolution = [[String]]()
    var pokemonPreviousEvolution = [[String]]()
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
        
        selectedPokemon = indexPath[1]
        let singlePokemonViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
        
        let viewTitle = pokemonID[selectedPokemon] + " " + pokemonNames[selectedPokemon].uppercased()
        
        //Passing the data to the PokemonViewController
        singlePokemonViewController.currentPokemonNumber = pokemonID[selectedPokemon]
        singlePokemonViewController.currentPokemonImage = pokemonImages[selectedPokemon]
        singlePokemonViewController.currentPokemonName = pokemonNames[selectedPokemon]
        singlePokemonViewController.currentPokemonDistance = pokemonDistance[selectedPokemon]
        singlePokemonViewController.currentPokemonType = pokemonType[selectedPokemon]
        //singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
        singlePokemonViewController.evolutions = pokemonEvolution[selectedPokemon]
        singlePokemonViewController.title = viewTitle

        
        
        let evolutions = pokemonEvolution[selectedPokemon]
        let previousEvolutions = pokemonPreviousEvolution[selectedPokemon]
        var numberOfEvolutions = 0
        var numberOfPreviousEvolutions = 0
        
        for _ in evolutions
        {
            if(evolutions[0] != "N/A")
            {
                numberOfEvolutions += 1
            }
        }
        
        for _ in previousEvolutions
        {
            if(previousEvolutions[0] != "N/A")
            {
                numberOfPreviousEvolutions += 1
            }
        }
        
        if (numberOfPreviousEvolutions == 0)
        {
            if (numberOfEvolutions == 0)
            {
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[selectedPokemon]
                singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
                singlePokemonViewController.currentCandyEvolveTwo = 0
                
            }
            
            else if (numberOfEvolutions == 1)
            {
                let stageOneImage = Int(evolutions[0])! - 1
                singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[selectedPokemon]
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[stageOneImage]
                singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
                singlePokemonViewController.currentCandyEvolveTwo = 0
                
            } else if (numberOfEvolutions == 2)
            {
                let stageOneImage = Int(evolutions[0])! - 1
                let stageTwoImage = Int(evolutions[1])! - 1
                singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[selectedPokemon]
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[stageOneImage]
                singlePokemonViewController.currentPokemonEvolutionStageThreeImage = pokemonImages[stageTwoImage]
                singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
                singlePokemonViewController.currentCandyEvolveTwo = pokemonCandy[stageOneImage]
                
            } else {}
        }
        
        else if (numberOfPreviousEvolutions == 1)
        {
            if (numberOfEvolutions == 1)
            {
                let previousEvolveImage = Int(previousEvolutions[0])! - 1
                let stageOneImage = Int(evolutions[0])! - 1
                singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[previousEvolveImage]
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[selectedPokemon]
                singlePokemonViewController.currentPokemonEvolutionStageThreeImage = pokemonImages[stageOneImage]
            }
            else if (numberOfEvolutions == 0){
                let previousEvolveImage = Int(previousEvolutions[0])! - 1
                singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[previousEvolveImage]
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[selectedPokemon]
            } else {}
            
        } else  if (numberOfPreviousEvolutions == 2){
            let previousEvolveImage = Int(previousEvolutions[0])! - 1
            let previousEvolveImageTwo = Int(previousEvolutions[1])! - 1
            singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[previousEvolveImage]
            singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[previousEvolveImageTwo]
            singlePokemonViewController.currentPokemonEvolutionStageThreeImage = pokemonImages[selectedPokemon]
            
        } else {
            
        }
        
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
                        }else { pokemonID.append("999") }
                        
                        //Pokemon Name
                        if let name = pokemon["name"] as? String {
                            pokemonNames.append(name)
                        }else { pokemonNames.append("N/A") }
                        
                        //Pokemon Image
                        if let imageURL = pokemon["img"] as? String {
                            
                            let myImage = try UIImage(data: NSData(contentsOf: NSURL(string:imageURL) as! URL) as Data)
                            self.pokemonImages.append(myImage!)
                            
                        } else { break }
                        
                        //Pokemon Type - Rework for two or one Pokemon Types
                        if let type = pokemon["type"] as? [String] {
                            var pokemonTypesCombined: String = ""
                            
                            for pokeType in type {
                                pokemonTypesCombined.append(pokeType + " ")
                            }
                            
                            pokemonType.append(pokemonTypesCombined)
                            
                        }else {
                            pokemonType.append("N/A")
                        }
                        
                        
                        if let previousPokemonEvolutions = pokemon["prevEvolution"] as? [String]
                        {
                            var arrayOfPrevEvolutions = [String]()
                            for evolution in previousPokemonEvolutions
                            {
                                arrayOfPrevEvolutions.append(evolution)
                            }
                            
                            pokemonPreviousEvolution.append(arrayOfPrevEvolutions)
                            
                        }else {
                            pokemonPreviousEvolution.append(["N/A"])
                        }
                        
                        //Pokemon Evolution - Rework for two or more Pokemon Evolutions
                        if let singlePokemonEvolutions = pokemon["nextEvolution"] as? [String] {
                            
                                var arrayOfEvolutions = [String]()
                            
                                for evolution in singlePokemonEvolutions
                                {
                                    arrayOfEvolutions.append(evolution)
                                }
                            
                                pokemonEvolution.append(arrayOfEvolutions)
                            
                        }else {
                            pokemonEvolution.append(["N/A"])
                        }
                        
                        //Pokemon Candy
                        if let pokemonSweets = pokemon["candy_count"] as? Int
                        {
                            pokemonCandy.append(pokemonSweets)
                        }else {
                            pokemonCandy.append(0)
                        }
                        
                        //Pokemon Distance per Candy
                        if let pokemonKM = pokemon["distance"] as? Int
                        {
                            pokemonDistance.append(pokemonKM)
                        }else {}
                     
                    } //For each Pokemon
                    
                    print(pokemonPreviousEvolution)
                    print(pokemonEvolution)
                    
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
