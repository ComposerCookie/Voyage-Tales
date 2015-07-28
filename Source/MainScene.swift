import Foundation

class MainScene: CCNode {
    let GAME_SPEED = 1.0;
    let socket = SocketIOClient(socketURL: "98.114.51.196:61250")
    let maxHairCountMale = 2;
    let maxHairCountFemale = 2;
    let maxEyeCountMale = 2;
    let maxEyeCountFemale = 2;
    weak var loginGUI : LoginGUI!;
    weak var createGUI : CreateGUI!;
    weak var selectCharGUI : SelectCharGUI!;
    weak var newCharGUI : NewCharGUI!;
    weak var inGame : InGame!;
    var currentTimestamp = 0.0;
    
    
    override func onEnter() {
        super.onEnter();
        
        self.addHandlers();
        self.socket.connect();

        loginGUI.initialize();
        createGUI.initialize();
        selectCharGUI.initialize();
        newCharGUI.initialize();
        inGame.initialize();
        
        loginGUI.enable(true);
    }
    
    override func update(delta: CCTime) {
        //super.update(delta);
        currentTimestamp += delta * GAME_SPEED;
    }
    
    func addHandlers() {
        self.socket.on("sReceivedConnection") {[weak self] data, ack in
            self?.serverReceivedConnection();
            return;
        };
        
        self.socket.on("sReceivedLoginInformation") {[weak self] data, ack in
            self?.serverReceivedLoginInfo();
            return;
        };
        
        self.socket.on("sLoginApproved") {[weak self] data, ack in
            self?.serverApproveLogin();
            return;
        };
        
        self.socket.on("sLoginDenied") {[weak self] data, ack in
            self?.serverDenyLogin();
            return;
        };
        
        self.socket.on("sSendCharacterList") {[weak self] data, ack in
            if let charCount = data?[0] as? Int{
                var char1 = data?[1] as? NSDictionary!;
                var char2 = data?[2] as? NSDictionary!;
                var char3 = data?[3] as? NSDictionary!;
                self?.serverSendCharacterList(charCount, char1: char1, char2: char2, char3: char3);
            }
            return;
        };
        
        self.socket.on("sAccountCreationApproved") {[weak self] data, ack in
            self?.serverApproveAccountCreation()
            return;
        };

        
        self.socket.on("sServerError") {[weak self] data, ack in
            self?.serverError();
            return;
        };
        
        self.socket.on("sUsernameApprove") {[weak self] data, ack in
            self?.serverApproveUsername();
            return;
        };
        
        self.socket.on("sUsernameExist") {[weak self] data, ack in
            self?.serverUsernameExist();
            return;
        };
        
        self.socket.on("sEmailExist") {[weak self] data, ack in
            self?.serverEmailExist();
            return;
        };
        
        self.socket.on("sEmailApprove") {[weak self] data, ack in
            self?.serverApproveEmail();
            return;
        };
        
        self.socket.on("sCharCreateApprove") {[weak self] data, ack in
            self?.serverApproveCharCreate();
            return;
        };
        
        self.socket.on("sCharSelectionApprove") {[weak self] data, ack in
            var char1 = data?[0] as? NSDictionary!;
            self?.serverApproveCharSelection(char1);
            return;
        };
        
        self.socket.on("sSendMap") {[weak self] data, ack in
            var Data = data![0] as! NSDictionary;
            var x = data?[1] as! Int;
            var y = data?[2] as! Int;
            self?.serverSendMap(Data, x: x, y: y);
            return;
        };
        
        self.socket.on("sApproveMovement") {[weak self] data, ack in
            var dir = data![0] as! Int;
            self?.serverApproveMovement(UInt8(dir));
            return;
        };
        
        self.socket.on("sUpdatePlayerPosition"){[weak self] data, ack in
            var curX = data![0] as! Int;
            var curY = data![1] as! Int;
            var dir = data![2] as! Int;
            
            self?.serverSendUpdatePlayerPos(curX, curY : curY, dir : dir);
        };
        
        self.socket.on("sBroadcastMsg") {[weak self] data, ack in
            println("this run");
            var msg = data![0] as! String;
            var msgType = data![1] as! Int;
            self?.serverBroadcastedMsg(msg, msgType: msgType);
            return;
        };
        
        self.socket.on("sSendNewCharOnMap"){[weak self] data, ack in
            var char1 = data?[0] as? NSDictionary!;
            
            self?.serverSendNewCharOnMap(char1);
        };
        
        self.socket.on("sUpdateOtherPlayerPosition"){[weak self] data, ack in
            var name = data![0] as! String;
            var curX = data![1] as! Int;
            var curY = data![2] as! Int;
            var dir = data![3] as! Int;
            
            self?.serverSendUpdateOtherPlayerPos(name, curX: curX, curY: curY, dir: dir)
        };
    }
    
    func serverApproveCharCreate(){
        newCharGUI.enable(false);
        selectCharGUI.enable(true);
    }
    
    func serverSendNewCharOnMap(char1 : NSDictionary!){
        var one : GameCharacter!;
        one = GameCharacter(n: char1["name"] as! String, g: char1["gender"] as! Int, s: char1["skin"] as! Int, d: char1["dir"] as! Int, h: char1["hair"] as! Int, hc: char1["hairColor"] as! Int, e: char1["eye"] as! Int, ec: char1["eyeColor"] as! Int, str: char1["strength"] as! Int, dex: char1["dexterity"] as! Int, end: char1["endurance"] as! Int, agi: char1["agility"] as! Int, int: char1["intelligence"] as! Int, wis: char1["wisdom"] as! Int, remain: char1["remaining"] as! Int, l: char1["level"] as! Int, exp: char1["cEXP"] as! Int);
        inGame.playerList.append(one);
    }
    
    
    func serverSendCharacterList(count:Int, char1:NSDictionary!, char2:NSDictionary!, char3:NSDictionary!){
        var one : GameCharacter!;
        var two : GameCharacter!;
        var three : GameCharacter!;
        
        if (char1 != nil){
            one = GameCharacter(n: char1["name"] as! String, g: char1["gender"] as! Int, s: char1["skin"] as! Int, d: char1["dir"] as! Int, h: char1["hair"] as! Int, hc: char1["hairColor"] as! Int, e: char1["eye"] as! Int, ec: char1["eyeColor"] as! Int, str: char1["strength"] as! Int, dex: char1["dexterity"] as! Int, end: char1["endurance"] as! Int, agi: char1["agility"] as! Int, int: char1["intelligence"] as! Int, wis: char1["wisdom"] as! Int, remain: char1["remaining"] as! Int, l: char1["level"] as! Int, exp: char1["cEXP"] as! Int)
        }
        if (char2 != nil){
            two = GameCharacter(n: char2["name"] as! String, g: char2["gender"] as! Int, s: char1["skin"] as! Int, d: char1["dir"] as! Int, h: char2["hair"] as! Int, hc: char2["hairColor"] as! Int, e: char2["eye"] as! Int, ec: char2["eyeColor"] as! Int, str: char2["strength"] as! Int, dex: char2["dexterity"] as! Int, end: char2["endurance"] as! Int, agi: char2["agility"] as! Int, int: char2["intelligence"] as! Int, wis: char2["wisdom"] as! Int, remain: char2["remaining"] as! Int, l: char2["level"] as! Int, exp: char2["cEXP"] as! Int)
        }
        if (char3 != nil){
            three = GameCharacter(n: char3["name"] as! String, g: char3["gender"] as! Int, s: char1["skin"] as! Int, d: char1["dir"] as! Int, h: char3["hair"] as! Int, hc: char3["hairColor"] as! Int, e: char3["eye"] as! Int, ec: char3["eyeColor"] as! Int, str: char3["strength"] as! Int, dex: char3["dexterity"] as! Int, end: char3["endurance"] as! Int, agi: char3["agility"] as! Int, int: char3["intelligence"] as! Int, wis: char3["wisdom"] as! Int, remain: char3["remaining"] as! Int, l: char3["level"] as! Int, exp: char3["cEXP"] as! Int)
        }
        selectCharGUI.updateChar(count, one: one, two: two, three: three);
    }
    
    func serverReceivedConnection(){
        loginGUI.lblStatus.string = "Online";
    }
    
    func serverReceivedLoginInfo(){
        loginGUI.lblError.string = "Processing...";
    }
    
    func serverApproveAccountCreation(){
        createGUI.enable(false);
        loginGUI.enable(true);
        loginGUI.lblError.string = "Account successfully created";
    }
    
    func serverApproveLogin(){
        loginGUI.lblError.string = "Login successful";
        loginGUI.enable(false);
        selectCharGUI.enable(true);
    }
    
    func serverDenyLogin(){
        loginGUI.lblError.string = "Wrong username or password";
    }
    
    func serverError(){
        loginGUI.lblError.string = "Error on the server side";
    }
    
    func serverApproveUsername(){
        
    }
    
    func serverUsernameExist(){
        
    }
    
    func serverApproveEmail(){
        
    }
    
    func serverEmailExist(){
        
    }
    
    func sendLoginInformation(user:String, pass:String){
        self.socket.emit("cAccountLogin", user, pass);
    }
    
    func sendCreateAccount(user:String, pass:String, email:String){
        self.socket.emit("cAccountCreate", user, pass, email);
    }
    
    func sendCreateCharacter(name:String, gender:UInt8, skin: UInt8, hair:Int, hColor:UInt8, eye:Int, eColor:UInt8, str:Int, end:Int, dex:Int, agi:Int, int:Int, wis:Int, remain:Int){
        self.socket.emit("cCharacterCreate", name, Int(gender), Int(skin), hair, Int(hColor), eye, Int(eColor), str, end, dex, agi, int, wis, remain);
        //self.socket.emit("cCharacterCreate", name, gender as! Int, skin as! Int, hair, hColor as! Int, eye, eColor as! Int, str, end, dex, agi, int, wis, remain);
            //"cCharacterCreate", name, gender, skin, hair, hColor, eye, eColor, str, end, dex, agi, int, wis, remain);
    }
    
    func sendSelectCharacter(charName : String){
        self.socket.emit("cCharPicked", charName);
    }
    
    func serverApproveCharSelection(char1 : NSDictionary!){
        inGame.loadPlayer(GameCharacter(n: char1["name"] as! String, g: char1["gender"] as! Int, s: char1["skin"] as! Int, d: char1["dir"] as! Int, h: char1["hair"] as! Int, hc: char1["hairColor"] as! Int, e: char1["eye"] as! Int, ec: char1["eyeColor"] as! Int, str: char1["strength"] as! Int, dex: char1["dexterity"] as! Int, end: char1["endurance"] as! Int, agi: char1["agility"] as! Int, int: char1["intelligence"] as! Int, wis: char1["wisdom"] as! Int, remain: char1["remaining"] as! Int, l: char1["level"] as! Int, exp: char1["cEXP"] as! Int));
        
        selectCharGUI.enable(false);
        inGame.enable(true);
    }
    
    func loadLayerFromArray(wid : Int, hei : Int, layer : [Int]) -> [[Int]]{
        var layerDataAsInt = [[Int]]();
        for (var y = 0; y < hei; y++){
            layerDataAsInt.append([]);
            for (var x = 0; x < wid; x++){
                layerDataAsInt[y].append(layer[y * wid + x]);
            }
        }
        
        return layerDataAsInt;
    }
    
    func serverSendMap(data : NSDictionary!, x: Int, y: Int){
        var mapdata = data["data"] as! NSDictionary;
        var cacheData = [[[Int]]]();
        for (var l = 0; l < 13; l++){
            cacheData.append([]);
        }
        
        var layercontainer = mapdata["layers"] as! NSArray;
        
        var layerdata = layercontainer[0] as! NSDictionary;
        var layer = layerdata["Ground"] as! [Int];
        var loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[0] = loadeddata;
        
        layerdata = layercontainer[1] as! NSDictionary;
        layer = layerdata["Ground2"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[1] = loadeddata;

        layerdata = layercontainer[2] as! NSDictionary;
        layer = layerdata["Floor"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[2] = loadeddata;

        layerdata = layercontainer[3] as! NSDictionary;
        layer = layerdata["Floor2"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[3] = loadeddata;

        layerdata = layercontainer[4] as! NSDictionary;
        layer = layerdata["WallIntBehind"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[8] = loadeddata;

        layerdata = layercontainer[5] as! NSDictionary;
        layer = layerdata["WallInt"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[9] = loadeddata;

        layerdata = layercontainer[6] as! NSDictionary;
        layer = layerdata["WallInt2"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[10] = loadeddata;

        layerdata = layercontainer[7] as! NSDictionary;
        layer = layerdata["WallIntHid"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[11] = loadeddata;

        layerdata = layercontainer[8] as! NSDictionary;
        layer = layerdata["WallIntDoor"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[12] = loadeddata;

        layerdata = layercontainer[9] as! NSDictionary;
        layer = layerdata["WallExt"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[4] = loadeddata;
        
        layerdata = layercontainer[10] as! NSDictionary;
        layer = layerdata["WallExt2"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[5] = loadeddata;
        
        layerdata = layercontainer[11] as! NSDictionary;
        layer = layerdata["Roof"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[6] = loadeddata;
        
        layerdata = layercontainer[12] as! NSDictionary;
        layer = layerdata["Roof2"] as! [Int];
        loadeddata = loadLayerFromArray(data["width"] as! Int, hei: data["height"] as! Int, layer: layer);
        cacheData[7] = loadeddata;
        
        inGame.loadNewMap(data["name"] as! String, data: cacheData);
        inGame.charMoved(x, charY: y);
    }
    
    func serverApproveMovement(dir : UInt8){
        inGame.playerChara.walk(dir);
        inGame.canMoveAgain = false;
    }
    
    func serverSendUpdatePlayerPos(curX : Int, curY : Int, dir : Int){
        if (inGame.requestFullUpdate < 10){
            inGame.charMoved(curX, charY: curY, dir: UInt8(dir));
            inGame.requestFullUpdate++;
        }
        else{
            inGame.charMoved(curX, charY: curY);
            inGame.requestFullUpdate = 0;
        }
        inGame.playerChara.dir = UInt8(dir);
        inGame.playerChara.reloadDrawer();
        inGame.canMoveAgain = true;
    }
    
    func serverSendUpdateOtherPlayerPos(name : String, curX : Int, curY : Int, dir : Int){
        inGame.updateOtherChar(name, curX: curX, curY: curY, dir: dir);
    }
    
    func sendRequestPlayerMovement(dir : UInt8){
        self.socket.emit("cRequestPlayerMovement", Int(dir));
    }
    
    func sendMovementCompleted(){
        self.socket.emit("cPlayerMoved");
    }
    
    func serverBroadcastedMsg(msg : String, msgType : Int){
        println("receive some kind of message for sure");
        inGame.chatGUI.receiveMessage(msg, msgType: msgType);
    }
    
    func sendChat(msg : String, msgType : Int){
        self.socket.emit("cSendChat", msg, msgType);
    }

}
