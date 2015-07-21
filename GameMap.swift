//
//  GameMap.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameMap : CCNode{
    var layer : [MapLayer]!;
    var mapName : String!;
    var width : Int!;
    var height : Int!;
    var layerCount : Int!;
    
    func initializeMap(n : String, lCount : Int, wid : Int, hei : Int){
        layer = [MapLayer]();
        
        mapName = n;
        layerCount = lCount;
        width = wid;
        height = hei;
        
        var lay : MapLayer!;
        
        for (var i = 0; i < layerCount; i++){
            
            
            lay = CCBReader.load("CCB Items/Layer") as! MapLayer;
            lay.initializeLayer(width, height: height)
            self.addChild(lay);
            layer.append(lay);
        }
        
        println("Map finish initialization");
    }
    
    func updateDrawLayer(index : Int, layerData : [[Int]]){
        for (var y = 0; y < height; y++){
            for (var x = 0; x < width; x++){
                layer[index].setTileValue(layerData[y][x], x: x, y: y);
            }
        }
    }
    
}