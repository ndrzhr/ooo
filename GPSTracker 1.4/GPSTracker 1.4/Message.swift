//
//  Message.swift
//  GPSTracker 1.4
//
//  Created by ndrzhr on 6/23/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import Foundation

struct Message {
    init(text:String,bySender:String){
        self.messageText = text;
        self.sender = bySender;
    }
    var messageText:String;
    var sender:String;
    
}