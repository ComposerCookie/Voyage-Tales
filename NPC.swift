//
//  Character.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class NPC{
    var name : String;
    var gender : UInt8;
    var skin : UInt8;
    var dir : UInt8;
    var hair : Int;
    var hairColor : UInt8;
    var eye : Int;
    var eyeColor : UInt8;
    var strength : Int;
    var dexterity : Int;
    var endurance : Int;
    var agility : Int;
    var intelligent : Int;
    var wisdom : Int;
    var remainingPoint : Int;
    var level : Int;
    var curEXP : Int;
    var frame : Int;
    var state : CharFrameType;
    var lastUpdatedTime : Double;
    var cooldown : Double;
    var tempFrame : Int = 0;
    var isPlayer : Bool;
    
    var charDrawer : CharacterDrawer;
    
    
    init(n : String, g : Int, s : Int, d : Int, h : Int, hc : Int, e : Int, ec : Int, str : Int, dex : Int, end : Int, agi : Int, int : Int, wis : Int, remain : Int, l : Int, exp : Int, player : Bool){
        name = n;
        gender = UInt8(g);
        skin = UInt8(s);
        dir = UInt8(d);
        hair = h;
        hairColor = UInt8(hc);
        eye = e;
        eyeColor = UInt8(ec);
        strength = str;
        endurance = end;
        dexterity = dex;
        agility = agi;
        intelligent = int;
        wisdom = wis;
        remainingPoint = remain;
        level = l;
        curEXP = exp;
        
        frame = 0;
        state = CharFrameType.stand;
        charDrawer = CCBReader.load("CCB Items/CharacterDrawer") as! CharacterDrawer;
        
        lastUpdatedTime = -1;
        cooldown = 0;
        
        isPlayer = player
    }
    
    func update(timeStamp : Double){
        if (lastUpdatedTime < 0){
            lastUpdatedTime = timeStamp;
        }
        
        switch (state){
        case CharFrameType.stand:
            break;
        case CharFrameType.walk:
            
            if (timeStamp > cooldown){
                tempFrame++;
                
                if (tempFrame > 7){
                    frame++
                    if (frame > 3){
                        frame = 0;
                        state = CharFrameType.stand;
                                            }
                    reloadDrawer();
                    tempFrame = 0;
                }
                
                cooldown = timeStamp + Data.getWalkFrameLength() / 8;
                lastUpdatedTime = timeStamp;
            }
            break;
        default:
            break;
            
        }
    }
    
    
    func walk(dir : UInt8){
        if (state != CharFrameType.stand){
            return;
        }
        
        self.dir = dir;
        reloadDrawer();
        state = CharFrameType.walk;
        
        tempFrame = 0;
    }
    
    func reloadDrawer(){
        charDrawer.updateCharacterLook(skin, gender: gender, eye: eye, eyeColor: eyeColor, hair: hair, hairColor: hairColor, dir : dir, frame : frame, frameType : state);
    }

    
}