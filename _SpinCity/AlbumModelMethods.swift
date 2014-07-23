//
//  AlbumModelMethods.swift
//  SpinCity
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

//import Foundation


extension AlbumModel {
    
    convenience init(title:String, artist:String, summary:String, price:Float, locationInStore:String) {
        self.init();
        self.name = title
        self.artistName = artist
        self.detail = summary
        self.price = price
        self.location = locationInStore
    }
    
    func description() -> Dictionary<String,String> {
        var _desc:Dictionary<String,String> = [
            "Name": self.name,
            "Price": "\(self.price)",
            "Artist Name": self.artistName,
            "Location": self.location,
            "Item Description": self.detail
        ];
        return _desc;
    }

}