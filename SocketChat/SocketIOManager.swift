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
//    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.4:3000")!)//HOME
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.10.234:3000")!)//WORK
    
    
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
    
    
    
    //--------------------------------------------------------------------------------------------------------------------------
    //MARK: - Operations

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
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    
    func getChatMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String
            messageDictionary["message"] = dataArray[1] as! String
            messageDictionary["date"] = dataArray[2] as! String
            
            completionHandler(messageInfo: messageDictionary)
        }
    }
    
}



