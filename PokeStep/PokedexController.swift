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
    var pokemonTypes = [[String]]()
    var pokemonEvolution = [[String]]()
    var pokemonPreviousEvolution = [[String]]()
    var pokemonCandy = [Int]()
    var pokemonDistance = [Int]()
    var selectedPokemon: Int = 0
    
    //declare this property where it won't go out of scope relative to your listener
    let reachability = Reachability()!

    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //changing the colour of the navigation controller to match the background
        //self.navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.00, green:0.10, blue:0.00, alpha:1.0)]
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.00, green:0.10, blue:0.00, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
                self.readPokemonJson()
            } else {
                print("Reachable via Cellular")
                self.readPokemonJson()
            }
        } else {
            print("Network not reachable")
            self.showNoInternetAlert(
                title: "No Internet Connection",
                message: "Sadly PokeStep requires internet connection to run. Please connect to the internet and then relaunch PokeStep."
            )
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Determines how many cells there are based on the number of Pokemon Names in the array pokemonNames
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonNames.count
    }
    
    //Assign the images and text to each cell based on its cell number
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
    
    //tells you which UICollectionView cell has been chosen. Pushes this information to the PokemonViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //get the cell that was chosen
        selectedPokemon = indexPath[1]
        
        //make an instance of the Pokemon View Controller
        let singlePokemonViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
        let viewTitle = pokemonID[selectedPokemon] + " " + pokemonNames[selectedPokemon].uppercased()
        
        //Passing the data to the PokemonViewController
        singlePokemonViewController.currentPokemonNumber = pokemonID[selectedPokemon]
        singlePokemonViewController.currentPokemonImage = pokemonImages[selectedPokemon]
        singlePokemonViewController.currentPokemonName = pokemonNames[selectedPokemon]
        singlePokemonViewController.currentPokemonDistance = pokemonDistance[selectedPokemon] 
        singlePokemonViewController.evolutions = pokemonEvolution[selectedPokemon]
        singlePokemonViewController.title = viewTitle

        //Handling how to display the info for Pokemon Type if a Pokemon has one or two
        let selectedPokemonType = pokemonTypes[selectedPokemon]
        var numberOfTypesInArray = 0
        for types in selectedPokemonType
        {
            if(types != "N/A")
            {
                numberOfTypesInArray += 1
            }
        }
        
        if(numberOfTypesInArray == 1){
            singlePokemonViewController.currentPokemonType = selectedPokemonType[0]
        }
        else if(numberOfTypesInArray == 2){
            var pokemonWithTwoTypes = selectedPokemonType[0]
            pokemonWithTwoTypes.append("/")
            pokemonWithTwoTypes.append(selectedPokemonType[1])
            
            singlePokemonViewController.currentPokemonType = pokemonWithTwoTypes
        }
        else {
        
        }
        
        //Evolution Stuff - Variables used to determine if a Pokemon has any future or previous evolutions
        let evolutions = pokemonEvolution[selectedPokemon]
        let previousEvolutions = pokemonPreviousEvolution[selectedPokemon]
        var numberOfEvolutions = 0
        var numberOfPreviousEvolutions = 0
        
        for evo in evolutions
        {
            if(evo != "N/A")
            {
                numberOfEvolutions += 1
            }
        }
        
        for preEvo in previousEvolutions
        {
            if(preEvo != "N/A")
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
            }
            
            else if (numberOfEvolutions == 1)
            {
                let stageOneImage = Int(evolutions[0])! - 1
                singlePokemonViewController.currentPokemonEvolutionStageOneImage = pokemonImages[selectedPokemon]
                singlePokemonViewController.currentPokemonEvolutionStageTwoImage = pokemonImages[stageOneImage]
                singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
                
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
                singlePokemonViewController.currentCandyEvolveOne = pokemonCandy[selectedPokemon]
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
        
        singlePokemonViewController.noOfEvolutions = numberOfEvolutions
        singlePokemonViewController.noOfPreviousEvolutions = numberOfPreviousEvolutions
        
        //Changes the View after the cell has been selected
        navigationController?.pushViewController(singlePokemonViewController, animated: true)

    }

    //The notification that will appear if there is no internet connectivity
    func showNoInternetAlert(title: String, message: String) {
        //build the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:  .default, handler: nil)
        
        //display the alert
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Read JSON file
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
                
                        //Pokemon Type and how to handle a Pokemon having multiple types
                        if let currentPokemontypes = pokemon["type"] as? [String]
                        {
                            var arrayOfPokemonType = [String]()
                            for type in currentPokemontypes
                            {
                                arrayOfPokemonType.append(type)
                            }
                            
                            pokemonTypes.append(arrayOfPokemonType)
                            
                        }else {
                            pokemonTypes.append(["N/A"])
                        }
                        
                        //Pokemon previous Evolutions and how to handle a Pokemon having multiple previous evolutions
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
                        
                        //Pokemon Evolution and how to handle multiple evoltuions
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
                    
                    //print(pokemonTypes)
                    
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
