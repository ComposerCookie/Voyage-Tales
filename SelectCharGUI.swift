//
//  SelectCharGUI.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SelectCharGUI : CCNode{
    weak var slot1 : CharPicker!;
    weak var slot2 : CharPicker!;
    weak var slot3 : CharPicker!;
    weak var btnCancel : CCButton!;
    weak var btnDelete : CCButton!;
    weak var btnMake : CCButton!;
    weak var btnSelect : CCButton!;
    weak var charSelector : CCSprite!;
    var charCount = 0;
    
    var curSelectedChar = 0;
    
    func initialize(){
        slot1.initialize(0);
        slot2.initialize(1);
        slot3.initialize(2);
        
    }
    
    func updateChar(count : Int, one : GameCharacter!, two : GameCharacter!, three : GameCharacter!){
        slot1.changeLoadedState(false);
        slot2.changeLoadedState(false);
        slot3.changeLoadedState(false);
        
        charCount = count;
        if one != nil{
            slot1.updateInformation(one);
        }
        if two != nil{
            slot2.updateInformation(two);
        }
        if three != nil{
            slot3.updateInformation(three);
        }
        
    }
    
    func makeOrPickCheck(flag : Bool){
        if (flag){
            btnMake.visible = false;
            btnSelect.visible = true;
            btnDelete.enabled = true;
        }
        else{
            btnMake.visible = true;
            btnSelect.visible = false;
            btnDelete.enabled = false;
        }
    }
    
    func selectedCharChanged(type : Int){
        charSelector.visible = true;
        curSelectedChar = type;
        switch (type){
        case 0:
            charSelector.position = CGPoint(x: 0, y: 67);
            makeOrPickCheck(slot1.loaded);
            break;
        case 1:
            charSelector.position = CGPoint(x: 0, y: -5);
            makeOrPickCheck(slot2.loaded);
            break;
        case 2:
            charSelector.position = CGPoint(x: 0, y: -81);
            makeOrPickCheck(slot3.loaded);
            break;
        default:
            break;
        }
    }
    
    func btnSelect_pressed(){
        let temp = self.parent as! MainScene;
        var name : String = "";
        switch (curSelectedChar){
        case 0:
            name = slot1.lblName.string;
            break;
        case 1:
            name = slot2.lblName.string;
            break;
        case 2:
            name = slot3.lblName.string;
            break;
        default:
            break;
        }
        temp.sendSelectCharacter(name);
    }
    
    func btnCancel_pressed(){
        let temp = self.parent as! MainScene;
        enable(false)
        temp.loginGUI.enable(true);
    }
    
    func btnMake_pressed(){
        let temp = self.parent as! MainScene;
        enable(false)
        temp.newCharGUI.enable(true);
    }
    
    func enable(flag: Bool){
        visible = flag;
        
        if (flag){
            charSelector.visible = false;
            btnMake.visible = false;
            btnSelect.visible = false;
            btnDelete.enabled = false;
        }
        
        btnCancel.userInteractionEnabled = flag;
        btnDelete.userInteractionEnabled = flag;
        btnCancel.userInteractionEnabled = flag;
        btnDelete.userInteractionEnabled = flag;

        slot1.enable(flag);
        slot2.enable(flag);
        slot3.enable(flag);
       
        userInteractionEnabled = flag;
    }
}