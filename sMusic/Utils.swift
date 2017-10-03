//
//  Utils.swift
//  sMusic
//
//  Created by Borja Fernandez on 3/10/17.
//  Copyright © 2017 Borja Fernandez. All rights reserved.
//

import Foundation

class Utils {
    
    func parsearJSON(_ data: Data?) {
        //Borramos las canciones que tenemos en la array
        searchResults.removeAll()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                // Get the results array
                if let array: AnyObject = response["canciones"] {
                    for trackDictonary in array as! [AnyObject] {
                        if let trackDictonary = trackDictonary as? [String: AnyObject], let previewUrl = trackDictonary["stream"] as? String {
                            // Parse the search result
                            let id = trackDictonary["id"] as? String
                            
                            let imagen = trackDictonary["imagen"] as? String
                            let name = trackDictonary["nombre"] as? String
                            let artist = trackDictonary["autor"] as? String
                            let duracion = trackDictonary["duracion"] as? String
                            searchResults.append(Track(name: name, artist: artist, previewUrl: previewUrl,imagen: imagen,identificador: id,duration:duracion))
                        } else {
                            print("Not a dictionary")
                        }
                    }
                } else {
                    print("Results key not found in dictionary")
                }
            } else {
                print("JSON Error")
            }
        } catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        
        
        self.obtenerDescargadas()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
            self.primeracancion()
        }
    }
    
    
}
