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
    var pokemonID = [Int]()
    var pokemonNames = [String]()
    var pokemonImages = [UIImage]()
    
    var pokemon = [Pokemon]()
    
    var pokemonType = [String]()
    var pokemonEvolution = [String]()
    var pokemonCandy = [Int]()
    var pokemonDistance = [Int]()
    
    var selectedPokemon: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readPokemonJson()
        
        
        //changing the colour of the navigation controller to match the background
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.92, green:0.89, blue:0.99, alpha:0.5)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.35, green:0.28, blue:0.43, alpha:1.0)]

    }
    
    //tells you which UICollectionView cell has been chosen
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPokemon = indexPath[1]
        let singlePokemonViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonViewController") as! PokemonViewController
        
        singlePokemonViewController.currentPokemonNumber = pokemonID[selectedPokemon]
        singlePokemonViewController.currentPokemonImage = pokemonImages[selectedPokemon]

        
        //Changes the View
        navigationController?.pushViewController(singlePokemonViewController, animated: true)
        
        print(selectedPokemon)

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
                        if let id = pokemon["id"] as? Int {
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
                            for pokeeType in type {
                                pokemonType.append(pokeeType)
                            }
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
                    
                    print(pokemonDistance)
                    
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
