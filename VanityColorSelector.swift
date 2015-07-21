//
//  vanityColorSelector.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class VanityColorSelector : CCNode{
    
    var selectorType = 0;
    
    weak var btnClr1 : CCButton!;
    weak var btnClr2 : CCButton!;
    weak var btnClr3 : CCButton!;
    weak var btnClr4 : CCButton!;
    weak var btnClr5 : CCButton!;
    weak var btnClr6 : CCButton!;
    weak var btnClr7 : CCButton!;
    weak var btnClr8 : CCButton!;
    weak var btnClr9 : CCButton!;
    weak var btnClr10 : CCButton!;
    weak var btnClr11 : CCButton!;
    weak var btnClr12 : CCButton!;
    weak var btnClr13 : CCButton!;
    weak var btnClr14 : CCButton!;
    weak var btnClr15 : CCButton!;
    weak var btnClr16 : CCButton!;
    weak var btnClr17 : CCButton!;
    weak var btnClr18 : CCButton!;
    weak var btnClr19 : CCButton!;
    weak var btnClr20 : CCButton!;
    weak var btnClr21 : CCButton!;
    weak var picSelector : CCSprite!;
    
    func initialize(type : Int){
        selectorType = type;
        
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
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        btnClr7.userInteractionEnabled = flag;
        
        userInteractionEnabled = flag;
    }

    
    func changeColor(color : UInt8){
        let temp = self.parent as! NewCharGUI;
        if (selectorType == 0){
            temp.changeHairColor(color);
        }
        else{
            temp.changeEyeColor(color);
        }
        picSelector.position = CGPoint(x: (Int)(color % 7) * 15 - 45, y: (Int)(color / 7) * -15 + 20);
    }
    
    func btnClr1_pressed(){
        changeColor(0);
    }
    
    func btnClr2_pressed(){
        changeColor(1);
    }
    
    func btnClr3_pressed(){
        changeColor(2);
    }
    
    func btnClr4_pressed(){
        changeColor(3);
    }
    
    func btnClr5_pressed(){
        changeColor(4);
    }
    
    func btnClr6_pressed(){
        changeColor(5);
    }
    
    func btnClr7_pressed(){
        changeColor(6);
    }
    
    func btnClr8_pressed(){
        changeColor(7);
    }
    
    func btnClr9_pressed(){
        changeColor(8);
    }
    
    func btnClr10_pressed(){
        changeColor(9);
    }
    
    func btnClr11_pressed(){
        changeColor(10);
    }
    
    func btnClr12_pressed(){
        changeColor(11);
    }
    
    func btnClr13_pressed(){
        changeColor(12);
    }
    
    func btnClr14_pressed(){
        changeColor(13);
    }
    
    func btnClr15_pressed(){
        changeColor(14);
    }
    
    func btnClr16_pressed(){
        changeColor(15);
    }
    
    func btnClr17_pressed(){
        changeColor(16);
    }
    
    func btnClr18_pressed(){
        changeColor(17);
    }
    
    func btnClr19_pressed(){
        changeColor(18);
    }
    
    func btnClr20_pressed(){
        changeColor(19);
    }
    
    func btnClr21_pressed(){
        changeColor(20);
    }
}