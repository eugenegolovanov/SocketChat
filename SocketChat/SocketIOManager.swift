//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by eugene golovanov on 6/15/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    
    //--------------------------------------------------------------------------------------------------------------------------
    //MARK: - Properties

    
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.4:3000")!)
    
    
    
    //--------------------------------------------------------------------------------------------------------------------------
    //MARK: - Init
    
    override init() {
        super.init()
    }
    

    //--------------------------------------------------------------------------------------------------------------------------
    //MARK: - Connection
    
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    
    func connectToServerWithNickname(nickname: String, completionHandler: (userList: [[String: AnyObject]]!) -> Void) {
        socket.emit("connectUser", nickname)
        
        socket.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(userList: dataArray[0] as! [[String: AnyObject]])
        }

    }
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    
}
