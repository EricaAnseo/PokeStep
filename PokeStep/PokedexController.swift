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
    var pokemonNames = [String]()
    var pokemonImages = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readPokemonJson()
        
        
        //changing the colour of the navigation controller to match the background
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.92, green:0.89, blue:0.99, alpha:0.5)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.35, green:0.28, blue:0.43, alpha:1.0)]

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
        
        //Tag 2 is assigned to the UILabel
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
                        if let name = pokemon["name"] as? String {
                            pokemonNames.append(name)
                        }else { break }
                        if let imageURL = pokemon["img"] as? String {
                            
                            let myImage = try UIImage(data: NSData(contentsOf: NSURL(string:imageURL) as! URL) as Data)
                            self.pokemonImages.append(myImage!)
                            
                        } else { break }
                    
                    }
                    
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
