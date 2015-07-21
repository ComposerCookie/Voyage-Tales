//
//  Tile.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Tile : CCSprite{
    var id : Int!;
    
    func initialize(ID : Int){
        id = ID;

        texture = Data.getMainTilesheet();
        setTextureRect(CGRect(x: ID % 32, y: ID / 32, width: 32, height: 32));
    }
    
    func changeID(ID : Int){
        visible = true;
        id = ID;
        if (ID == 0){
            visible = false;
        }
        
        var temp = ID - 1;
        
        setTextureRect(CGRect(x: temp % 32 * 32, y: temp / 32 * 32, width: 32, height: 32));
        //setTextureRect(CGRect(x: 32, y: 32, width: 32, height: 32));
    }
}