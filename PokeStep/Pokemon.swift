//
//  Pokemon.swift
//  PokeStep
//
//  Created by 20063209 on 22/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class Pokemon {

    //MARK: Properties
    var pokemonID: Int
    var pokemonName: String
    var pokemonImage: UIImage?
    //var pokemonType: String
    //var pokemonEvolution: String
    var pokemonCandy: Int
    var pokemonDistance: Int
    
    
    
    //MARK: Initialization
    
    init?(id: Int, name: String, image: UIImage?, candy: Int, km: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (candy >= 0) && (candy <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.pokemonID = id
        self.pokemonName = name
        self.pokemonImage = image
        self.pokemonCandy = candy
        self.pokemonDistance = km
        
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
