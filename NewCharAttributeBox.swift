//
//  NewCharAttributeBox.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/7/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class NewCharAttributeBox : CCNode{
    weak var lblAttribute : CCLabelTTF!;
    weak var btnPlus : CCButton!;
    weak var btnMinus : CCButton!;
    
    var value = 1;
    
    func btnPlus_pressed(){
        let temp = self.parent as! NewCharGUI;
        if (temp.remainingAttribute > 0){
            value++;
            temp.remainingAttribute--;
        }
        lblAttribute.string = "\(value)";
        temp.lblRemaining.string = "\(temp.remainingAttribute)";
    }
    
    func btnMinus_pressed(){
        let temp = self.parent as! NewCharGUI;
        if (value > 1){
            value--;
            temp.remainingAttribute++;
        }
        lblAttribute.string = "\(value)";
        temp.lblRemaining.string = "\(temp.remainingAttribute)";
    }
    
    func enable(flag: Bool){
        visible = flag;
    }
}