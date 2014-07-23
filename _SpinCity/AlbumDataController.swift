//
//  AlbumDataController.swift
//  SpinCity
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

import Foundation

class AlbumDataController {
	var _albumList:Array<AlbumModel> = [];

	init() {
		_albumList = Array<AlbumModel>();
		self._initializeDefaultAlbums();
	}

    func _initializeDefaultAlbums() {
        var pathToAlbumsPlist:String = NSBundle.mainBundle().pathForResource("AlbumArray", ofType: "plist");
        var defaultAlbumPlist:Array = NSArray(contentsOfFile: pathToAlbumsPlist);
        
        for albumInfo in defaultAlbumPlist {
            self.addAlbumWithTitle(
                albumInfo["title"] as String,
                artist: albumInfo["artist"] as String,
                summary:albumInfo["summary"] as String,
                price: (albumInfo["price"] as Float),
                locationInStore: albumInfo["locationInStore"] as String
            );
        }
    }
    
    func albumCount() -> Int {
        var _t:Int = self._albumList.count;
        return _t;
    }
    
    func albumAtIndex(index:Int) -> AlbumModel {
        return _albumList[index];
    }
    
    func addAlbumWithTitle(title:String, artist:String, summary:String, price:Float, locationInStore location:String) {
        var newAlbum:AlbumModel = AlbumModel(title: title, artist: artist, summary: summary, price: price, locationInStore: location);
        self._albumList.append(newAlbum)   	
    }
}