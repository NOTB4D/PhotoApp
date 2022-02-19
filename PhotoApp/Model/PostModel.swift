//
//  PostModel.swift
//  PhotoApp
//
//  Created by Eser Kucuker on 19.02.2022.
//

import Foundation

class PostModdel{
    var email:String
    var command: String
    var imageUrl: String
    
    init(email:String, command:String, imageUrl:String){
        self.email = email
        self.imageUrl = imageUrl
        self.command = command
    }
}
