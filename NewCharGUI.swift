//
//  NewCharGUI.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class NewCharGUI : CCNode{
    weak var charViewer : CharacterViewer!;
    weak var btnCancel : CCButton!;
    weak var btnMake : CCButton!;
    weak var hairClrSelector : VanityColorSelector!;
    weak var eyeClrSelector : VanityColorSelector!;
    weak var skinClrSelector : SkinColorSelector!;
    weak var hairPlus : CCButton!;
    weak var hairMinus : CCButton!;
    weak var eyePlus : CCButton!;
    weak var eyeMinus : CCButton!;
    weak var lblHairStyle : CCLabelTTF!;
    weak var lblEyeStyle : CCLabelTTF!;
    weak var btnMale : CCButton!;
    weak var btnFemale : CCButton!;
    weak var attrStr : NewCharAttributeBox!;
    weak var attrEnd : NewCharAttributeBox!;
    weak var attrDex : NewCharAttributeBox!;
    weak var attrAgi : NewCharAttributeBox!;
    weak var attrInt : NewCharAttributeBox!;
    weak var attrWis : NewCharAttributeBox!;
    weak var lblRemaining : CCLabelTTF!;
    weak var txtName : CCTextField!;
    
    var remainingAttribute = 24;
    
    func initialize(){
        charViewer.initialize();
        eyeClrSelector.initialize(1);
        txtName.textField.textColor = UIColor.whiteColor();
        
        btnMale.selected = true;
    }
    
    func enable(flag: Bool){
        visible = flag;
        
        if (flag){
            charViewer.reset();
        }
        
        charViewer.enable(flag);
        hairClrSelector.enable(flag);
        skinClrSelector.enable(flag);
        attrStr.enable(flag);
        attrEnd.enable(flag);
        attrDex.enable(flag);
        attrAgi.enable(flag);
        attrWis.enable(flag);
        attrInt.enable(flag);
        
        userInteractionEnabled = flag;
    }
    
    func btnMale_pressed(){
        charViewer.changeGender(0);
        btnMale.selected = true;
        btnFemale.selected = false;
    }
    
    func btnFemale_pressed(){
        charViewer.changeGender(1);
        btnFemale.selected = true;
        btnMale.selected = false;
    }
    
    func btnCancel_pressed(){
        let temp = self.parent as! MainScene;
        enable(false);
        temp.selectCharGUI.enable(true);
    }
    
    func btnMake_pressed(){
        let temp = self.parent as! MainScene;
        temp.sendCreateCharacter(txtName.textField.text, gender: charViewer.gender, skin: charViewer.skinColor, hair: charViewer.hair, hColor: charViewer.hairColor, eye: charViewer.eye, eColor: charViewer.eyeColor, str: attrStr.value, end: attrEnd.value, dex: attrDex.value, agi: attrAgi.value, int: attrInt.value, wis: attrWis.value, remain: remainingAttribute)
        
    }
    
    func changeHairColor(color : UInt8){
        charViewer.changeHairColor(color)
    }
    
    func changeEyeColor(color : UInt8){
        charViewer.changeEyeColor(color);
    }
    
    func changeSkinColor(color : UInt8){
        charViewer.changeSkinColor(color);
    }
    
    func hairPlus_pressed(){
        charViewer.changeHairStyle(true);
    }
    
    func hairMinus_pressed(){
        charViewer.changeHairStyle(false);
        
    }
    
    func eyeMinus_pressed(){
        charViewer.changeEyeStyle(false);
    }
    
    func eyePlus_pressed(){
        charViewer.changeEyeStyle(true);
    }

}