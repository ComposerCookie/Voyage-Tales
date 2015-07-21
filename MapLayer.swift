//
//  MapLayer.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class MapLayer : CCNode{
    var tileGrid : [[Tile]]!;
    
    func initializeLayer(width : Int, height : Int){
        tileGrid = [[Tile]]();
        var t : Tile;
        for (var y = 0; y < height; y++){
            tileGrid.append([]);
            for (var x = 0; x < width; x++){
                t = CCBReader.load("CCB Items/Tile") as! Tile;
                t.initialize(0);
                t.position = CGPoint(x: (x - 1) * 32, y: y * -32 + ((Data.getMaxTileY() - 2) * 32));
                addChild(t);
                tileGrid[y].append(t);
            }
        }
        println("finished initializing a layer");
    }
    
    func setTileValue(id: Int, x : Int, y: Int){
        tileGrid[y][x].changeID(id);
    }
    
}