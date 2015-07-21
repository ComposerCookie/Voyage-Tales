//
//  Data.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/11/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Data{
    static var className = [String]();
    static let mainTilesheet = CCTexture(file: "Graphics/Tileset/Tileset.png");
    static let spriteWidth = 64;
    static let spriteHeight = 64;
    static let screenMaxTileX = 22;
    static let screenMaxTileY = 14;
    static let layerCount = 13;
    static let walkFrameLength : Double = 0.124;
    
    class func updateClassName(nameList : [String]){
        className = nameList;
    }
    
    class func getClassName(id : Int) -> String{
        return className[id];
    }
    
    class func getMainTilesheet() -> CCTexture{
        return mainTilesheet;
    }
    
    class func getSpriteWidth() -> Int {
        return spriteWidth;
    }
    
    class func getSpriteHeight() -> Int{
        return spriteHeight;
    }
    
    class func getMaxTileX() -> Int{
        return screenMaxTileX;
    }
    
    class func getMaxTileY() -> Int{
        return screenMaxTileY;
    }
    
    class func getLayerCount() -> Int{
        return layerCount;
    }
    
    class func getWalkFrameLength() -> Double{
        return walkFrameLength;
    }
}