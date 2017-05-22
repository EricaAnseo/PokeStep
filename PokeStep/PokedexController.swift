//
//  PokedexController.swift
//  PokeStep
//
//  Created by 20063209 on 05/05/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class PokedexCollectionViewController: UICollectionViewController {
    
    var pokemonNames = ["Bulbasaur","Ivysaur", "Venasaur", "Bulbasaur", "Ivysaur", "Venasaur", "Bulbasaur", "Ivysaur", "Venasaur", "Bulbasaur","Ivysaur", "Venasaur"]
    var pokemonPictures = [UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg"), UIImage(named: "001.jpg"), UIImage(named: "002.jpg"), UIImage(named: "003.jpg")]
    
    var pokedex = [[String:Any]]()
    var names = [String]()
    var pokemonImages = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readPokemonJson()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
        //return pokemonPictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemon", for: indexPath) as UICollectionViewCell

        //Tagged assigned in storyboard. Tag 1 is assigned to the UIimage
        let pokemonImage = pokemon.viewWithTag(1) as! UIImageView
        
        //Tag 2 is assigned to the UILabel
        let pokemonName = pokemon.viewWithTag(2) as! UILabel
        
        pokemonImage.image = pokemonImages[indexPath.row]

        pokemonName.text = names[indexPath.row]
        
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
                            names.append(name)
                        }else { break }
                        if let imageURL = pokemon["img"] as? String {
                            
                            //dispatch_async(DispatchQueue.global( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                
                                let myImage = try UIImage(data: NSData(contentsOf: NSURL(string:imageURL) as! URL) as Data)
                                self.pokemonImages.append(myImage!)
                           // })
                            
                            /*let pokemonPictureURL = URL(string: imageURL)!
                            
                            // Creating a session object with the default configuration.
                            // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
                            let session = URLSession(configuration: .default)
                            
                            // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                            let downloadPicTask = session.dataTask(with: pokemonPictureURL) { (data, response, error) in
                                // The download has finished.
                                if let e = error {
                                    print("Error downloading pokemon picture: \(e)")
                                } else {
                                    // No errors found.
                                    // It would be weird if we didn't have a response, so check for that too.
                                    if (response as? HTTPURLResponse) != nil {
                                        if let imageData = data {
                                            // Finally convert that Data into an image and do what you wish with it.
                                            let onlineImage = UIImage(data: imageData)
                                            // Do something with your image.
                                            
                                            self.pokemonImages.append(onlineImage!)
                                            
                                        } else {
                                            print("Couldn't get image: Image is nil")
                                        }
                                    } else {
                                        print("Couldn't get response code for some reason")
                                    }
                                }
                            }
                            
                            downloadPicTask.resume()*/
                            
                        } //else { break }
                    
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
