//
//  LoginGUI.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 6/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class LoginGUI : CCNode{
    weak var txtUser : CCTextField!;
    weak var txtPass : CCTextField!;
    weak var btnLogin : CCButton!;
    weak var btnCreate : CCButton!;
    weak var lblStatus : CCLabelTTF!;
    weak var lblError : CCLabelTTF!;
    
    func initialize() {
        //txtUser.textField.font =
        txtUser.textField.textColor = UIColor.whiteColor();
        txtPass.textField.textColor = UIColor.whiteColor();
        
        enable(true);
    }
    
    func btnLogin_pressed(){
        let temp = self.parent as! MainScene;
        temp.sendLoginInformation(txtUser.textField.text, pass: txtPass.textField.text);
    }
    
    func btnCreate_pressed(){
        let temp = self.parent as! MainScene
        enable(false);
        temp.createGUI.enable(true);
    }
    
    func enable(flag: Bool){
        visible = flag;
        txtUser.textField.enabled = flag;
        txtPass.textField.enabled = flag;
        
        txtUser.textField.text = "";
        txtPass.textField.text = "";
        
        btnLogin.userInteractionEnabled = flag;
        btnCreate.userInteractionEnabled = flag;
        userInteractionEnabled = flag;
    }
    
}