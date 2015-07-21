//
//  characterHUD.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class CharPicker : CCNode{
    weak var lblName : CCLabelTTF!;
    weak var lblClass : CCLabelTTF!;
    weak var lblEXP : CCLabelTTF!;
    weak var lblLevel : CCLabelTTF!;
    weak var select : CCButton!;
    var type = 0;
    var loaded = false;
    
    func enable(flag: Bool){
        visible = flag;
        
        userInteractionEnabled = flag;
    }
    
    func initialize(t: Int){
        type = t;
        changeLoadedState(false);
    }
    
    func this_pressed(){
        let temp = self.parent as! SelectCharGUI;
        temp.selectedCharChanged(type);
    }
    
    func updateInformation(chara : GameCharacter){
        lblName.string = chara.name;
        //lblClass.string =
        lblLevel.string = "Lvl: \(chara.level)";
        //lblEXP.string
        changeLoadedState(true);
        
    }
    
    func changeLoadedState(flag : Bool){
        loaded = flag;
        if (flag){
            //lblName.visible = flag;
        }
        else{
            lblName.string = "Empty Slot";
        }
        lblClass.visible = flag;
        lblEXP.visible = flag;
        lblLevel.visible = flag;
    }

}