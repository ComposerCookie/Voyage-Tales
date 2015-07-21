//
//  skinColorSelector.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SkinColorSelector : CCNode{
    weak var btnClr1 : CCButton!;
    weak var btnClr2 : CCButton!;
    weak var btnClr3 : CCButton!;
    weak var btnClr4 : CCButton!;
    weak var btnClr5 : CCButton!;
    weak var btnClr6 : CCButton!;
    weak var btnClr7 : CCButton!;
    
    weak var picSelector : CCSprite!;
    
    func changeColor(color : UInt8){
        let temp = self.parent as! NewCharGUI;
        temp.changeSkinColor(color);
        picSelector.position = CGPoint(x: (Int)(6 - color % 7) * 15 - 45, y: 3);
    }
    
    func enable(flag: Bool){
        visible = flag;
        
        btnClr1.userInteractionEnabled = flag;
        btnClr2.userInteractionEnabled = flag;
        btnClr3.userInteractionEnabled = flag;
        btnClr4.userInteractionEnabled = flag;
        btnClr5.userInteractionEnabled = flag;
        btnClr6.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        userInteractionEnabled = flag;
    }
    
    func btnClr1_pressed(){
        changeColor(6);
    }
    
    func btnClr2_pressed(){
        changeColor(5);
    }
    
    func btnClr3_pressed(){
        changeColor(4);
    }
    
    func btnClr4_pressed(){
        changeColor(3);
    }
    
    func btnClr5_pressed(){
        changeColor(2);
    }
    
    func btnClr6_pressed(){
        changeColor(1);
    }
    
    func btnClr7_pressed(){
        changeColor(0);
    }

}