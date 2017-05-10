//
//  PokedexController.swift
//  PokeStep
//
//  Created by 20063209 on 05/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {
    
    //var pokemonNames = ["Bulbasaur","Ivysaur", "Venasaur", "Bulbasaur", "Ivysaur", "Venasaur", "Bulbasaur", "Ivysaur", "Venasaur", "Bulbasaur","Ivysaur", "Venasaur"]
    var pokemonPictures = [UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg")]
    
    var pokedex = [[String:Any]]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readPokemonJson()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonPictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemon", for: indexPath) as UICollectionViewCell
        
        //Tagged assigned in storyboard. Tag 1 is assigned to the UIimage
        let pokemonImage = pokemon.viewWithTag(1) as! UIImageView
        
        pokemonImage.image = pokemonPictures[indexPath.row]
        
        //Tag 2 is assigned to the UILabel
        //let pokemonName = pokemon.viewWithTag(2) as! UILabel
        
        //pokemonName.text = pokemonNames[indexPath.row]
        
        return pokemon
    }
    
    private func readPokemonJson() {
        do {
            //if a json file called pokedex exists
            if let file = Bundle.main.url(forResource: "pokedex", withExtension: "json") {
                
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let pokedexObject = json as? [String: Any] {
                    
                    readJSONObject(object: pokedexObject as [String : AnyObject])
                    
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
    
    func readJSONObject(object: [String: AnyObject]) {
        guard //let pokemonID = object["id"] as? String,
            //let version = object["swiftVersion"] as? Float,
            let pocketMonsters = object["pokemon"] as? [[String: AnyObject]] else { return }
       
        
        for pokemon in pocketMonsters {
            guard let num = pokemon["num"] as? String,
                let name = pokemon["name"] as? String else { break }
            
                print(num + name)
            
            //switch num {
            //case "001":
                //print(num + " is \(name) years old.")
            //case "002":
               // _ = num + " is \(name) years old."
            //case "003":
               // _ = num + " is \(name) years old."
            //default:
                //break
            //}
        }
    }
    
    
    
}
