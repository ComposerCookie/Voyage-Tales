//
//  CharacterDrawer.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class CharacterDrawer : CCNode{
    weak var baseSprite : CCSprite!;
    weak var eyeSprite : CCSprite!;
    weak var hairSprite : CCSprite!;
    
    func initialize(skin : UInt8, gender : UInt8, eye : Int, eyeColor : UInt8, hair : Int, hairColor : UInt8, dir : UInt8, frame : Int){
        updateCharacterLook(skin, gender: gender, eye: eye, eyeColor: eyeColor, hair: hair, hairColor: hairColor, dir : dir, frame : frame, frameType : CharFrameType.stand);
    }
    
    func updateCharacterLook(skin : UInt8, gender : UInt8, eye : Int, eyeColor : UInt8, hair : Int, hairColor : UInt8, dir : UInt8, frame : Int, frameType : CharFrameType){
        if (gender == 0){
            baseSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Base/male_base_\(skin + 1).png")
            hairSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Hairs/\(hair + 1)/Hair\(hair + 1)_\(hairColor + 1).png")
            eyeSprite.texture = CCTexture(file: "Graphics/Sprites/Male/Eyes/\(eye + 1)/Eye\(eye + 1)_\(eyeColor + 1).png")
        }
        else{
            baseSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Base/female_base_\(skin + 1).png")
            hairSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Hairs/\(hair + 1)/Hair\(hair + 1)_\(hairColor + 1).png")
            eyeSprite.texture = CCTexture(file: "Graphics/Sprites/Female/Eyes/\(eye + 1)/Eye\(eye + 1)_\(eyeColor + 1).png")
        }
        //baseSprite.position = CGPoint(x: 0, y: 28);
        //hairSprite.position = CGPoint(x: 0, y: 28);
        //eyeSprite.position = CGPoint(x: 0, y: 28);
        baseSprite.position = CGPoint(x: Data.getMaxTileX() * 32 / 2 - 64, y: (Data.getMaxTileY() - 2) * 32 / 2);
        hairSprite.position = CGPoint(x: Data.getMaxTileX() * 32 / 2 - 64, y: (Data.getMaxTileY() - 2) * 32 / 2);
        eyeSprite.position = CGPoint(x: Data.getMaxTileX() * 32 / 2 - 64, y:  (Data.getMaxTileY() - 2) * 32 / 2);

        updateCharacterFrame(dir, frame : frame, type : frameType);
    }
    
    func updateCharacterFrame(dir : UInt8, frame : Int, type : CharFrameType){
        var multiplierY = 0;
        switch (dir){
        case 0:
            multiplierY = 2;
            break;
        case 1:
            multiplierY = 3;
            break;
        case 2:
            multiplierY = 0;
            break;
        case 3:
            multiplierY = 1;
            break;
        default:
            break;
        }
        switch (type){
        case CharFrameType.stand:
            baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            break;
        case CharFrameType.sit:
            baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 10, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
            break;
        case CharFrameType.walk:
            switch(frame){
            case 0, 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 1, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 0, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 2, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }
            break;
        case CharFrameType.running:
            switch (frame){
            case 0, 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 3, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 4, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3, 5:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 5, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 4:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 6, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }
            break;
        case CharFrameType.wave:
            switch (frame){
            case 0, 10:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1, 9:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 2, 4, 6, 8:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3, 5, 7:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            default:
                break;
            }

            break;
        case CharFrameType.ohyeah:
            switch (frame){
            case 0, 4:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth(), y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 1:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 7, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 2:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 8, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;
            case 3:
                baseSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                eyeSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                hairSprite.setTextureRect(CGRect(x: Data.getSpriteWidth() * 9, y: Data.getSpriteHeight() * multiplierY, width: Data.getSpriteWidth(), height: Data.getSpriteHeight()));
                break;

            default:
                break;
            }
            break;
        default:
            break;
        }
    }
}