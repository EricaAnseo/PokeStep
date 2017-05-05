//
//  PokedexController.swift
//  PokeStep
//
//  Created by 20063209 on 05/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {
    
    var pokemonNames = ["Bulbasaur","Ivysaur", "Venasaur"]
    var pokemonPictures = [UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg")]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var pokemon = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemon", for: indexPath) as UICollectionViewCell
        
        //Tagged assigned in storyboard
        var pokemonImage = pokemon.viewWithTag(1) as! UIImageView
        
        pokemonImage.image = pokemonPictures[indexPath.row]
        
        var pokemonName = pokemon.viewWithTag(2) as! UILabel
        
        pokemonName.text = pokemonNames[indexPath.row]
        
        return pokemon
    }
    
    
    
}
