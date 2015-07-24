//
//  InGame.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class InGame : CCNode{
    var bottomMap : GameMap!;
    var topMap : GameMap!;
    var insideMap : GameMap!;
    var playerChara : GameCharacter!;
    var curMapData : [[[Int]]]!;
    var renderData : [[[Int]]]!;
    var keepMovingTap : Bool = false;
    var lastTouch : CCTouch!;
    var canMoveAgain : Bool = true;
    var NPCList : [NPC] = [];
    
    weak var chatGUI : ChatGUI!;
    
    var middleY = (Data.getMaxTileY() - 2) * 32 / 2 - 48;
    var middleX = Data.getMaxTileX() * 32 / 2 - 32;
    
    var bufferArray : [Int] = [];
    var lastTouchInChat : Bool = false
    var lastTouchAfterMove = CCTouch()
    var moveIt = false
    
    override func update(delta: CCTime) {
        let temp = self.parent as! MainScene;
        if (playerChara != nil){
            playerChara.update(temp.currentTimestamp)
            
            if (keepMovingTap && canMoveAgain){
                var touchLocation = lastTouch.locationInNode(self);
                var isVertical = abs(middleY - Int(touchLocation.y)) > abs(middleX - Int(touchLocation.x));
                if (isVertical){
                    //Data.getMaxTileX() * 32 / 2, y: (Data.getMaxTileY() - 2) * 32 / 2)
                    if (Int(touchLocation.y) > middleY){
                        temp.sendRequestPlayerMovement(0);
                    }
                    else if (Int(touchLocation.y) < middleY){
                        temp.sendRequestPlayerMovement(2);
                    }
                }
                else{
                    if (Int(touchLocation.x) > middleX){
                        temp.sendRequestPlayerMovement(1);
                    }
                    else if (Int(touchLocation.x) < middleX){
                        temp.sendRequestPlayerMovement(3);
                    }
                }
            }
        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        keepMovingTap = false;
        moveIt = false

    }
    
    override func touchCancelled(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        moveIt = false
        //
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        println("-----touchMoved-----")
        if lastTouchInChat {
            if moveIt {
                println("is getting to the calculation of the offset")
                var offset = touch.locationInWorld().y - lastTouchAfterMove.locationInWorld().y
                chatGUI.moveByOffset(offset)
            }
        }
        lastTouchAfterMove = touch
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
        var temp = self.parent as! MainScene;
        
        
        lastTouch = touch;
        
        if (touch.tapCount > 1){
            keepMovingTap = true;
            lastTouchInChat = false
        } else {
            if (touch.locationInWorld().x < 300) && (touch.locationInWorld().y < 230) {
                lastTouchInChat = true
                chatGUI.originalTouch = touch.locationInWorld()
                moveIt = true
            } else {
                lastTouchInChat = false
            }
        }
    }
    
    func initialize(){
        bottomMap = CCBReader.load("CCB Items/Map") as! GameMap;
        topMap = CCBReader.load("CCB Items/Map") as! GameMap;
        insideMap = CCBReader.load("CCB Items/Map") as! GameMap;
        
        bottomMap.initializeMap("name", lCount: 6, wid: Data.getMaxTileX(), hei: Data.getMaxTileY());
        topMap.initializeMap("name", lCount: 2, wid: Data.getMaxTileX(), hei: Data.getMaxTileY());
        insideMap.initializeMap("name", lCount: 5, wid: Data.getMaxTileX(), hei: Data.getMaxTileY());

        
        curMapData = [[[Int]]]();
        renderData = [[[Int]]]();
        
        for (var l = 0; l < 13; l++){
            renderData.append([])
            for (var y = 0; y < Data.getMaxTileY(); y++){
                renderData[l].append([]);
                for (var x = 0; x < Data.getMaxTileX(); x++){
                    renderData[l][y].append(0);
                }
            }
        }
        
        for (var l = 0; l < 13; l++){
            curMapData.append([])
            for (var y = 0; y < 50; y++){
                curMapData[l].append([]);
                for (var x = 0; x < 50; x++){
                    curMapData[l][y].append(0);
                }
            }
        }
        
        for (var b = 0; b < Data.getMaxTileX(); b++){
            bufferArray.append(0);
        }
        
        insideMap.visible = false;
    }
    
    func loadNewMap(n : String, data : [[[Int]]]){
        bottomMap.name = n;
        curMapData = data;
    }
    
    
    
    func charMoved(charX : Int, charY : Int, dir : UInt8){
        let screenWidth = Data.getMaxTileX()
        let screenHeight = Data.getMaxTileY()
        let halfMaxX = Data.getMaxTileX() / 2;
        let halfMaxY = Data.getMaxTileY() / 2;
        
        switch(dir) {
        case 0: // up -> add row at 0, remove bottom
            let newTop = charY - halfMaxY
            if (newTop >= 0 && newTop < 50) { // Only the first one might get into trouble, but it best to check anyway
                for (var l = 0; l < 13; l++) {
                    for (var x = 0; x < screenWidth; x++) { // Scrolling through all the potiental X Value to draw
                        let tilePos = charX - halfMaxX + x
                        if (tilePos < 50 && tilePos >= 0) {
                            bufferArray[x] = curMapData[l][newTop][tilePos];
                        }
                        else{
                            bufferArray[x] = 0;
                        }
                    }
                    renderData[l].insert(bufferArray, atIndex: 0);
                    renderData[l].removeLast();
                }
            } else {
                for (var x = 0; x < screenWidth; x++) {
                    bufferArray[x] = 0;
                }
                
                for (var l = 0; l < 13; l++) {
                    renderData[l].insert(bufferArray, atIndex: 0);
                    renderData[l].removeLast();
                }
            }
            break;
        case 1: // right -> add at bottom, remove 0
            let newRight = charX + halfMaxX
            if (newRight >= 0 && newRight < 50) { // Only the first one might get into trouble, but it best to check anyway
                for (var l = 0; l < 13; l++) {
                    for (var y = 0; y < screenHeight; y++) { // Scrolling through all the potiental Y Value to draw
                        let tilePos = charY - halfMaxY + y
                        if (tilePos < 50 && tilePos >= 0) {
                            renderData[l][y].append(curMapData[l][tilePos][newRight - 1])
                        } else {
                            renderData[l][y].append(0);
                        }
                        renderData[l][y].removeAtIndex(0);
                    }
                }
            } else {
                for (var l = 0; l < 13; l++) {
                    for (var y = 0; y < screenHeight; y++) {
                        renderData[l][y].append(0);
                        renderData[l][y].removeAtIndex(0);
                    }
                }
            }
            
            break;
        case 2: // down -> add row at bottom, remove at 0
            let newBottom = charY + halfMaxY
            if (newBottom >= 0 && newBottom < 50) { // Only the first one might get into trouble, but it best to check anyway
                for (var l = 0; l < 13; l++){
                    for (var x = 0; x < screenWidth; x++) { // Scrolling through all the potiental X Value to draw
                        let tilePos = charX - halfMaxX + x
                        if (tilePos < 50 && tilePos >= 0) {
                            bufferArray[x] = curMapData[l][newBottom - 1][tilePos];
                        } else {
                            bufferArray[x] = 0;
                        }
                    }
                    
                    renderData[l].append(bufferArray)
                    renderData[l].removeAtIndex(0);
                }
            } else {
                for (var x = 0; x < screenWidth; x++) {
                    bufferArray[x] = 0;
                }
                
                for (var l = 0; l < 13; l++) {
                    renderData[l].append(bufferArray)
                    renderData[l].removeAtIndex(0)
                }
            }
            
            break;
        case 3: // left -> shift through all, add at 0, remove at bottom
            let newLeft = charX - halfMaxX
            if (newLeft >= 0 && newLeft < 50) { // Only the first one might get into trouble, but it best to check anyway
                for (var l = 0; l < 13; l++) {
                    for (var y = 0; y < screenHeight; y++) { // Scrolling through all the potiental Y Value to draw
                        let tilePos = charY - halfMaxY + y
                        if (tilePos < 50 && tilePos >= 0) {
                            renderData[l][y].insert(curMapData[l][tilePos][newLeft], atIndex: 0)
                        } else {
                            renderData[l][y].insert(0, atIndex: 0);
                        }
                        renderData[l][y].removeLast();
                    }
                }
            } else {
                for (var l = 0; l < 13; l++) {
                    for (var y = 0; y < screenHeight; y++) {
                        renderData[l][y].insert(0, atIndex: 0);
                        renderData[l][y].removeLast();
                    }
                }
            }
            break;
        default:
            break;
        }
        
        for (l, layer) in enumerate(renderData) {
            if (l < 6) {
                bottomMap.updateDrawLayer(l, layerData: layer);
            } else if (l >= 6 && l < 8) {
                topMap.updateDrawLayer(l - 6, layerData: layer);
            } else {
                insideMap.updateDrawLayer(l - 8, layerData: layer);
            }
        }
        
        bottomMap.position = CGPoint(x: -32, y: 0);
        topMap.position = CGPoint(x: -32, y: 0);
        insideMap.position = CGPoint(x: -32, y: 0);
    }
    
    func charMoved(charX : Int, charY : Int){
        let halfMaxX = Data.getMaxTileX() / 2;
        let halfMaxY = Data.getMaxTileY() / 2;
        for (var l = 0; l < 13; l++){
            for (var y = 0; y < Data.getMaxTileY(); y++){
                for (var x = 0; x < Data.getMaxTileX(); x++){
                    if ((charY - halfMaxY + y) >= 0 && (charX - halfMaxX + x) >= 0 && (charY - halfMaxY + y) < 50 && (charX - halfMaxX + x) < 50){
                        renderData[l][y][x] = curMapData[l][charY - halfMaxY + y][charX - halfMaxX + x];
                    }
                    else{
                        renderData[l][y][x] = 0;
                    }
                }
            }
            if (l < 6){
                bottomMap.updateDrawLayer(l, layerData: renderData[l]);
            }
            else if (l >= 6 && l < 8){
                topMap.updateDrawLayer(l - 6, layerData: renderData[l]);
            }
            else{
                insideMap.updateDrawLayer(l - 8, layerData: renderData[l]);
            }
        }
        
        bottomMap.position = CGPoint(x: -32, y: 0);
        topMap.position = CGPoint(x: -32, y: 0);
        insideMap.position = CGPoint(x: -32, y: 0);
    }
    
    func loadPlayer(player : GameCharacter){
        addChild(bottomMap);
        if (playerChara != nil){
            removeChild(playerChara.charDrawer);
        }
        addChild(insideMap);
        
        playerChara = player;
        playerChara.reloadDrawer();
        playerChara.setAsCamerator(self);
        addChild(playerChara.charDrawer);
        addChild(topMap);
    }
    
    func enable(flag: Bool){
        visible = flag;
        userInteractionEnabled = flag;
        if (flag){
            print("user interaction should be enabled");
        }
    }

}