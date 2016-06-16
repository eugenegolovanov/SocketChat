//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by eugene golovanov on 6/15/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.4:3000")!)
    
    
    //
    func establishConnection() {
        socket.connect()
    }
    
    
    func closeConnection() {
        socket.disconnect()
    }
    
    override init() {
        super.init()
    }
    
    
    
}
