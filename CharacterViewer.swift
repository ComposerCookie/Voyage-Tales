//
//  CharacterViewer.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class CharacterViewer : CCNode{
    weak var baseSprite : CCSprite!;
    weak var hairSprite : CCSprite!;
    weak var eyeSprite : CCSprite!;
    weak var btnStand : CCButton!;
    weak var btnSit : CCButton!;
    weak var btnWalk : CCButton!;
    weak var btnRun : CCButton!;
    
    var state = 0;
    var frame = 0;
    var gender : UInt8 = 0;
    var hair = 0;
    var eye = 0;
    var skinColor : UInt8 = 0;
    var hairColor : UInt8 = 0;
    var eyeColor : UInt8 = 0;
    var lastUpdated = -1.0;
    
    func initialize(){
        reset();
    }
    
    func reset(){
        let temp = self.parent.parent as! MainScene;

        frame = 0;
        gender = 0;
        hair = 0;
        eye = 0;
        skinColor = 0;
        hairColor = 0;
        eyeColor = 0;
        lastUpdated = -1.0;
        
        baseSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Base/male_base_1.png");
        baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
        hairSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Hairs/1/Hair1_1.png");
        hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
        eyeSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Eyes/1/Eye1_1.png");
        eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
    }
    
    func btnStand_pressed(){
        state = 0;
    }
    
    func btnSit_pressed(){
        state = 1;
    }
    
    func btnWalk_pressed(){
        state = 2;
    }
    
    func btnRun_pressed(){
        state = 3;
    }
    
    func changeGender(which: UInt8){
        gender = which;
        hair = -1;
        eye = -1;
        hairColor = 0;
        eyeColor = 0;
        changeSkinColor(skinColor);
        changeHairStyle(true);
        changeEyeStyle(true);
    }
    
    func changeSkinColor(color: UInt8){
        skinColor = color;
        if (gender == 0){
            baseSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Base/male_base_\(skinColor + 1).png");
        }
        else{
            baseSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Base/female_base_\(skinColor + 1).png");
        }
    }
    
    func changeHairColor(color : UInt8){
        hairColor = color;
        if (gender == 0){
            hairSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Hairs/\(hair + 1)/Hair\(hair + 1)_\(hairColor + 1).png");
        }
        else{
            hairSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Hairs/\(hair + 1)/Hair\(hair + 1)_\(hairColor + 1).png");
        }
        
    }
    
    func changeHairStyle(plus : Bool){
        let temp = self.parent.parent as! MainScene;
        let temp2 = self.parent as! NewCharGUI;
        if (plus){
            hair++;
        }
        else {
            hair--;
        }
        if (gender == 0 && hair >= temp.maxHairCountMale){
            hair = 0;
        }
        
        else if (gender == 1 && hair >= temp.maxHairCountFemale){
            hair = 0;
        }
        
        else if (hair < 0 && gender == 0){
            hair = temp.maxHairCountMale - 1;
        }
        
        else if (hair < 0 && gender == 1){
            hair = temp.maxHairCountFemale - 1;
        }
        
        temp2.lblHairStyle.string = "\(hair + 1)";
        changeHairColor(hairColor);
    }
    
    func changeEyeStyle(plus : Bool){
        let temp = self.parent.parent as! MainScene;
        let temp2 = self.parent as! NewCharGUI;
        if (plus){
            eye++;
        }
        else {
            eye--;
        }
        if (gender == 0 && eye >= temp.maxEyeCountMale){
            eye = 0;
        }
            
        else if (gender == 1 && eye >= temp.maxEyeCountFemale){
            eye = 0;
        }
            
        else if (eye < 0 && gender == 0){
            eye = temp.maxEyeCountMale - 1;
        }
        
        else if (eye < 0 && gender == 1){
            eye = temp.maxEyeCountFemale - 1;
        }
        
        temp2.lblEyeStyle.string = "\(eye + 1)";
        changeEyeColor(eyeColor);
    }
    
    func changeEyeColor(color : UInt8){
        eyeColor = color;
        if (gender == 0){
            eyeSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Eyes/\(eye + 1)/Eye\(eye + 1)_\(eyeColor + 1).png");
        }
        else{
            eyeSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Eyes/\(eye + 1)/Eye\(eye + 1)_\(eyeColor + 1).png");
        }
        
    }
    
    func enable(flag: Bool){
        visible = flag;
        
        baseSprite.visible = flag;
        hairSprite.visible = flag;
        eyeSprite.visible = flag;

        btnStand.userInteractionEnabled = flag;
        btnSit.userInteractionEnabled = flag;
        btnWalk.userInteractionEnabled = flag;
        btnRun.userInteractionEnabled = flag;
        userInteractionEnabled = flag;
    }
    
    func handleFrame(){
        let temp = self.parent.parent as! MainScene;
        switch (state){
        case 0:
            switch (frame){
            case 0, 10, 11, 12, 13, 14, 18, 19, 20:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1, 9:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 2, 4, 6, 8:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3, 5, 7:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 15:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 16:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 17:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight(), width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }
            break;
        case 1:
            switch (frame){
            case 0:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }
            break;
        case 2:
            switch(frame){
            case 0, 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 4, 6:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 5:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 7:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 8, 10:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 9:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 11:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 12, 14:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 13:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 15:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
                
            default:
                break;
            }
            break;
        case 3:
            switch (frame){
            case 0, 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3, 5:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 4:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 0, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 6, 8:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 7:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 9, 11:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 10:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 1, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 12, 14:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 13:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 15, 17:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 16:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 2, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 18, 20:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 19:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 21, 23:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 22:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * 3, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }
            break;
        default:
            break;
        }
    }
    
    override func update(delta: CCTime) {
        let temp = self.parent.parent as! MainScene;
        
        if (lastUpdated < 0){
            lastUpdated = temp.currentTimestamp;
        }
        
        switch (state){
        case 0: // standing
            if (temp.currentTimestamp - lastUpdated > 0.17){
                frame++;
                if (frame >= 21){ // there are 15 frames in total, 11 for waving, and 4 frames for "YEAH"!, filter in 6 so 21
                    frame = 0;
                }
                handleFrame();
                lastUpdated = temp.currentTimestamp;
            }
            break;
        case 1: // sitting
            if (temp.currentTimestamp - lastUpdated > 0.80){
                frame++;
                if (frame >= 4){ // there are 4 frames in total
                    frame = 0;
                }
                handleFrame();
                lastUpdated = temp.currentTimestamp;

            }
            break;
        case 2: // walking
            if (temp.currentTimestamp - lastUpdated > 0.30){
                frame++;
                if (frame >= 16){ // 16 frames total, 4 for each directions
                    frame = 0;
                }
                handleFrame();
                lastUpdated = temp.currentTimestamp;

            }
            
            break;
        case 3: // running
            if (temp.currentTimestamp - lastUpdated > 0.17){
                frame++;
                if (frame >= 24){ // 24 frames, 6 frames for each direction
                    frame = 0;
                }
                handleFrame();
                lastUpdated = temp.currentTimestamp;
            }
            break;
        default:
            break;
        }
    }

}