//
//  Animal.swift
//  It's a Zoo in There
//
//  Created by Yutong Sun on 1/16/24.
//

import Foundation
import UIKit

class Animal: CustomStringConvertible {
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    let soundPath: String
    let id: UUID
    
    init(name: String, species: String, age: Int, image: UIImage, soundPath: String) {
            self.name = name
            self.species = species
            self.age = age
            self.image = image
            self.soundPath = soundPath
            self.id = UUID()
        }
    var description: String {
            return "Animal: name = \(name), species = \(species), age = \(age), uuid = \(id)"
        }
}
