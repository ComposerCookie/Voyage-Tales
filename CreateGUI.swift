//
//  CreateGUI.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 6/25/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class CreateGUI : CCNode{
    weak var txtUser : CCTextField!;
    weak var txtPass : CCTextField!;
    weak var txtRePass : CCTextField!;
    weak var txtEmail : CCTextField!;
    weak var btnSubmit : CCButton!;
    weak var btnClear : CCButton!;
    weak var btnCancel : CCButton!;
    
    func initialize() {
        txtUser.textField.textColor = UIColor.whiteColor();
        txtPass.textField.textColor = UIColor.whiteColor();
        txtRePass.textField.textColor = UIColor.whiteColor();
        txtEmail.textField.textColor = UIColor.whiteColor();
        
        enable(false);
    }
    
    func btnSubmit_pressed(){
        if txtPass.textField.text != txtRePass.textField.text{
            return;
        }
        
        let temp = self.parent as! MainScene;
        temp.sendCreateAccount(txtUser.textField.text, pass: txtPass.textField.text, email: txtEmail.textField.text);
    }
    
    func btnClear_pressed(){
        txtUser.textField.text = "";
        txtPass.textField.text = "";
        txtRePass.textField.text = "";
        txtEmail.textField.text = "";
    }
    
    func btnCancel_pressed(){
        let temp = self.parent as! MainScene;
        enable(false)
        temp.loginGUI.enable(true);
        //temp.sendLoginInformation(txtUser.textField.text, pass: txtPass.textField.text)
    }
    
    func enable(flag: Bool){
        visible = flag;
        txtUser.textField.enabled = flag;
        txtPass.textField.enabled = flag;
        txtRePass.textField.enabled = flag;
        txtEmail.textField.enabled = flag;
        
        txtUser.textField.text = "";
        txtPass.textField.text = "";
        txtRePass.textField.text = "";
        txtEmail.textField.text = "";
        
        btnSubmit.userInteractionEnabled = flag;
        btnClear.userInteractionEnabled = flag;
        btnCancel.userInteractionEnabled = flag;
        userInteractionEnabled = flag;
    }
    
}