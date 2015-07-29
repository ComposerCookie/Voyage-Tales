//
//  ChatGUI.swift
//  VoyageClient
//
//  Created by Jacqueline Tiana Tran on 7/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//



//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB
//THIS ONE IS NOT FROM GIT HUB


import Foundation

class ChatGUI: CCNode {
    weak var btnDown:CCButton!
    weak var btnEnter:CCButton!
    weak var btnLocal:CCButton!
    weak var btnShow:CCButton!
    weak var btnSystem:CCButton!
    weak var btnUp:CCButton!
    weak var btnWorld:CCButton!
    weak var txtChat:CCTextField!
    weak var hideableNode:CCNode!
    weak var chatBackground:CCNode!
    weak var messages:CCNode!
    
    //var messages:CCNode!
    
    
    var originalTouch:CGPoint?
    
    //0 -> World
    //1 -> System
    //2 -> Local\
    var currentChatScope = 0
    var chatScope:Int = 0 {
        didSet {
            updateChatScope(currentChatScope)
            currentChatScope = chatScope
            updateChatArray()
            receiveMessage("", msgType: chatScope)
        }
    }
    
    var screenHeight:CGFloat = 0.0
    //this variable needs to be changed
    
    var ghostChat : CCLabelTTF = CCLabelTTF()
    
    
    //stored chats
    var chatArrayLocal : [CCLabelTTF] = []
    var topArrayLocal : [CCLabelTTF] = []
    var bottomArrayLocal : [CCLabelTTF] = []
    
    var chatArraySystem : [CCLabelTTF] = []
    var topArraySystem : [CCLabelTTF] = []
    var bottomArraySystem : [CCLabelTTF] = []
    
    var chatArrayWorld : [CCLabelTTF] = []
    var topArrayWorld : [CCLabelTTF] = []
    var bottomArrayWorld : [CCLabelTTF] = []
    
    
    //curent chat
    var chatArray : [CCLabelTTF] = []
    var topArray : [CCLabelTTF] = []
    var bottomArray : [CCLabelTTF] = []
    
    
    var mainSceneoffset = 0
    
    var totalHeight:CGFloat = 0
    var messageJustEntered = false
    
    
    
    func enable(flag : Bool){
        self.visible = flag
    }
    
    func didLoadFromCCB() {
        self.userInteractionEnabled = true
        initialize()
    }
    
    func initialize(){
       // messages = self.parent.
        screenHeight = chatBackground.boundingBox().height + txtChat.boundingBox().height - 30
        self.zOrder = 50
        txtChat.textField.textColor = UIColor.whiteColor();
        
    }

    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        println("----------")
        println("chatwas touched")
        originalTouch = touch.locationInWorld()
    }
    
    func txtChat_entered(){
        var sendThis = "\(txtChat.string)"
        if sendThis != "" {
            sendMessage(sendThis);
            txtChat.string = "";
        }
    }
    
    func btnEnter_pressed(){
        for i in 0 ... 10 {
            sendMessage("\(i)")
            
        }
    }
    
    func moveByOffset(offset : CGFloat) {
        println("------moveByOffset------")
        println("gets to offset")
        println("=-=-=-=the offset is \(offset)=-=-=-=")
        var aTempVal:CGFloat? = nil
        if chatArray.count > 0 {
            aTempVal = chatArray[0].position.y
        }
        for var i = 0; i < chatArray.count; i += 1 {
            //scroll up
            if chatArray.count > 0 {
                if offset > 0 {
                    if aTempVal! < 20 {
                        //checking just in casebut should never conflict
                        chatArray[i].position.y += offset * 0.4
                    } else {
                        if bottomArray.count > 0 {
                            chatArray.insert(bottomArray.last!, atIndex: 0)
                            bottomArray.removeLast()
                        }
                    }
                } else  if offset < 0 {
//                    if chatArray.last!.position.y > screenHeight - 15 {
                        chatArray[i].position.y += offset * 0.4
                        println("added an offset of")
//                    } else {
//                        println("add more text")
//                    }
                }
            }
            
            if chatArray.count > 0 {
                    //chatArray.insert(temp, atIndex: 0)
                    chatArray[0].position.y = txtChat.boundingBox().height
                    
                
                    
                    println("chat array count is: \(chatArray.count)")
                    if chatArray.count > 1 {
                        for i in 1 ... chatArray.count - 1 {
                            chatArray[i].position.y = chatArray[i].boundingBox().height + chatArray[i - 1].position.y
                            println("the message: [\(chatArray[i].string)] was positioned at: \(chatArray[i].position)")
                            
                        }
                    }
            }
            
        } // your mom is a good editor
        //i dont have a mom, she died of liver cancer.your a terrible person :*(
        updateChatArray()
    }
    
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //TODO: Scroll text
        
        println("-----touchMoved()-----")
        println("The chat touch moved")
        
        var offset = touch.locationInWorld().y - originalTouch!.y
  
        //map funnction
        moveByOffset(offset)
        
        
        
        originalTouch = touch.locationInWorld()
        
        
        
    }
    
    func sendMessage(msg : String) {
        var temp = parent.parent as! MainScene;
        temp.sendChat(msg, msgType: chatScope);
        
    }
    
    func receiveMessage(msg : String, msgType : Int){
        println("-----recieveMessage()-----")
        
        messageJustEntered = true
        
        var temp = CCLabelTTF(string: msg, fontName: "Graphics/rainyhearts.ttf", fontSize: 16);
        temp.anchorPoint = CGPoint(x: 0,y: 0)
        temp.zOrder = 50
        //updateChatScope(chatScope)
        println("bottomArrayWorld.count = \(bottomArray.count)")
        if count(msg) > 0 {
        //if true {
            switch msgType {
                
            case 0:
                if bottomArrayWorld.count > 0 {
                    println("inserted into the bottom array")
                    bottomArrayWorld.insert(temp, atIndex: 0)
                } else {
                    println("inserted into world chat array")
                    chatArrayWorld.insert(temp, atIndex: 0)
                    println("the chat array world is = \(chatArrayWorld)")
                }
                println("this part was reached")
                break;
            case 1:
                if bottomArraySystem.count > 0 {
                    bottomArraySystem.insert(temp, atIndex: 0)
                } else {
                    chatArraySystem.insert(temp, atIndex: 0)
                }
                break;
            case 2:
                if bottomArrayLocal.count > 0 {
                    bottomArrayLocal.insert(temp, atIndex: 0)
                } else {
                    chatArrayLocal.insert(temp, atIndex: 0)
                }
                break;
                
            default:
                break;
            }
        }
        
        checkScope()
        
        
//to fix duplication
        if chatArray.count > 0 {
            if msgType == chatScope {
    //            chatArray.insert(temp, atIndex: 0)
                chatArray[0].position.y = txtChat.boundingBox().height
            
                println("A message was recieved")
                println("The message is: \(msg)")
                
                println("chat array count is: \(chatArray.count)")
                if chatArray.count > 1 {
                    for i in 1 ... chatArray.count - 1 {
                        chatArray[i].position.y = chatArray[i].boundingBox().height + chatArray[i - 1].position.y
                        println("the message: [\(chatArray[i].string)] was positioned at: \(chatArray[i].position)")
                        
                    }
                }
            }
        }
    
        updateChatArray()
        //fix fontName and fontSiz
        //put message in correct array
    }
    
    func updateChatArray() {
        
        println("------updateChatArray()--------")
        println("updating array")
        var i = 0
        while i < chatArray.count {
            var topHeight : CGFloat = 0.0
            var bottomHeight : CGFloat = 0.0
            var yPos = chatArray[i].position.y
            

            topHeight = 15.0
            bottomHeight = 10.0
//            for i in 0 ..< topArray.count {
//                topHeight += topArray[i].boundingBox().height
//            }
//            for i in 0 ..< bottomArray.count {
//                bottomHeight += bottomArray[i].boundingBox().height
//            }
            // fix bounds
            
            
            if yPos > CGFloat(screenHeight) + 1 {
                println("--------------")
                println("--------------")
                println("--appending---")
                println("--------------")
                println("--------------")
                println("fuck you ")
                
                chatArray[i].removeFromParent()
                topArray.append(chatArray[i])
                chatArray.removeAtIndex(i)
                if !messageJustEntered {
                    if bottomArray.count > 0 {
                        chatArray.insert(bottomArray.removeLast(), atIndex: 0)
                        messages.addChild(chatArray[0])
                    }
                }
                i -= 1
                
            } else if yPos > CGFloat(screenHeight) {
                chatArray[i].visible = false
            } else if yPos + chatArray[i].boundingBox().height > txtChat.boundingBox().height {
                chatArray[i].visible = true
                //fix overlap with scope buttons
            } else if yPos + chatArray[i].boundingBox().height > txtChat.boundingBox().height - 1 {
                chatArray[i].visible = false
            } else {
                chatArray[i].removeFromParent()
                bottomArray.append(chatArray.removeAtIndex(i))
                if topArray.count > 0 {
                    chatArray.append(topArray.removeLast())
                    messages.addChild(chatArray.last!)
                    
                    i -= 1
                }
            }
            i += 1
            
            updateChatScope(chatScope)
        }
        
        println("the chat array is: ")
        var textArray : [String] = []
        var positionArray : [CGPoint] = []
        for label in chatArray {
            textArray.append("\(label.string)")
            positionArray.append(label.position)
        }
        println("\(textArray)")
        println("\(positionArray)")
        
        
        messages.removeAllChildren()
        
        for label in chatArray {
            messages.addChild(label)
        }
        
        
        messageJustEntered = false
    }
    
    func btnWorld_pressed(){
        chatScope = 0
        println("chatScope was set to \(chatScope)")
    }
    
    func btnSystem_pressed() {
        chatScope = 1
        println("chatScope was set to \(chatScope)")
    }
    
    func btnLocal_pressed() {
        chatScope = 2
        println("chatScope was set to \(chatScope)")
    }
    
    func checkScope() {
        switch chatScope {
        case 0:
            topArray = topArrayWorld
            chatArray = chatArrayWorld
            bottomArray = bottomArrayWorld
            break;
        case 1:
            topArray = topArraySystem
            chatArray = chatArraySystem
            bottomArray = bottomArraySystem
            break;
        case 2:
            topArray = topArrayLocal
            chatArray = chatArrayLocal
            bottomArray = bottomArrayLocal
            break;
        default:
            break
        }
        
    }
    
    func updateChatScope(currentScope : Int) {
        switch currentScope {
        case 0:
            topArrayWorld = topArray
            chatArrayWorld = chatArray
            bottomArrayWorld = bottomArray
            break;
        case 1:
            topArraySystem = topArray
            chatArraySystem = chatArray
            bottomArraySystem = bottomArray
            break;
        case 2:
            topArrayLocal = topArray
            chatArrayLocal = chatArray
            bottomArrayLocal = bottomArray
            break;
        default:
            break;
        }
        
        switch chatScope {
        case 0:
            topArray = topArrayWorld
            chatArray = chatArrayWorld
            bottomArray = bottomArrayWorld
            break;
        case 1:
            topArray = topArraySystem
            chatArray = chatArraySystem
            bottomArray = bottomArraySystem
            break;
        case 2:
            topArray = topArrayLocal
            chatArray = chatArrayLocal
            bottomArray = bottomArrayLocal
            break;
        default:
            break
        }
        
    }
    
    func btnShow_pressed() {
        hideableNode.visible = !hideableNode.visible
    }
    
}