//
//  ViewController.swift
//  GPSTracker 1.4
//
//  Created by ndrzhr on 6/22/15.
//  Copyright (c) 2015 ndrzhr. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITextFieldDelegate, NSURLSessionDataDelegate,NSURLSessionDelegate {
    let url = NSURL(string: "http://ndrzhr.selfip.com:8080/MainServlet");

    var userName:String = "nadir";
    let otherUserColor = UIColor(red: 102.0, green: 204.0, blue: 255.0, alpha: 1.0);
    var tableView:UITableView!;
    var btnSend:UIButton!;
    var btnGet:UIButton!;
    var data:[Message] = [Message]();
    var textField: UITextField?;
    var textViewWidth = CGFloat(260);
    var tableViewRect: CGRect!;
    var btnSendRect: CGRect!;
    var bntGetRect: CGRect!;
    var textFieldRect: CGRect!;
    var tableViewRectWithKeyboard: CGRect!;
    var btnSendRectWithKeyboard: CGRect!;
    var textFieldRectWithKeyboard: CGRect!;
    var keyboardShowFirstTime = true;
    var checkMessagesTimer:NSTimer?;
    var userNameController: UIAlertController?;
    var session: NSURLSession!;
    var isCheckingForMessages = false;
    var lastMessageId = 0;

    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<20{
            let message = Message(text: "row number \(i)", bySender: "someone");
           // data.append(message);
        }
        
        tableViewRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 50);
        tableView = UITableView(frame: tableViewRect, style: UITableViewStyle.Plain);
        tableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
        tableView.dataSource = self;
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "tableViewIdentifier");
        //view.addSubview(tableView);
        
        textFieldRect = CGRect(x: 0, y: tableView.frame.maxY + CGFloat(2), width: textViewWidth, height: 50)
        textField = UITextField(frame: textFieldRect);
        textField?.placeholder = "some message..";
        textField?.delegate = self;
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        view.addSubview(textField!);
        
        btnSend = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        btnSendRect = CGRect(x: textViewWidth, y: tableView.frame.maxY + CGFloat(2), width: view.frame.width - textViewWidth, height: 50);
        btnSend.frame = btnSendRect;
        btnSend.setTitle("Send", forState: UIControlState.Normal);
        btnSend.addTarget(self, action: "handleSend:", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(btnSend);
        
        userNameController = UIAlertController(title: "user name", message: "please enter your username", preferredStyle: UIAlertControllerStyle.Alert);
        let action = UIAlertAction(title: "Done", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            println("action !!")
        }
        userNameController?.addAction(action);
        userNameController?.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
            textField.placeholder = "user name...";
        });
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("tableViewIdentifier") as! UITableViewCell;/*
        cell.textLabel?.text = data[indexPath.row].messageText;
        if(data[indexPath.row].sender == userName){
            cell.textLabel?.textAlignment = NSTextAlignment.Right;
            cell.contentView.backgroundColor = UIColor.lightGrayColor();
        }else{
            cell.textLabel?.textAlignment = NSTextAlignment.Left;
            cell.contentView.backgroundColor = otherUserColor;
        }
        var senderLable: UILabel?;
        for subView in cell.contentView.subviews{
            if subView.tag == 1992{
                senderLable = subView as? UILabel;
                break;
            }
        }
        if(senderLable == nil){
            senderLable = UILabel(frame: CGRect(x: 10, y: 20, width: cell.contentView.frame.width, height: 30));
            senderLable!.tag = 1992;
            senderLable!.font = UIFont.systemFontOfSize(8);
            cell.contentView.addSubview(senderLable!);
        }
        senderLable!.text = data[indexPath.row].sender;
        if(data[indexPath.row].sender == userName){
            senderLable?.textAlignment = NSTextAlignment.Right;
        }*/
        return cell;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func handleKeyboardDidShow(notification: NSNotification){
        println("keyboard did show");
        
        let keyboardRectAsObject  = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue;
        
        var keyboardRect = CGRectZero;
        keyboardRectAsObject.getValue(&keyboardRect);
        println("keyboardRect: \(keyboardRect)");
        
        if(keyboardShowFirstTime){
            let newYValue = tableView.frame.height-keyboardRect.height;
            tableViewRectWithKeyboard = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: newYValue);
            textFieldRectWithKeyboard = CGRect(x: 0, y: newYValue + CGFloat(2), width: textViewWidth, height: 50);
            btnSendRectWithKeyboard = CGRect(x: textViewWidth, y: newYValue + CGFloat(2), width: view.frame.width - textViewWidth, height: 50);
            keyboardShowFirstTime = false;
        }
        tableView.frame = tableViewRectWithKeyboard;
        textField?.frame = textFieldRectWithKeyboard;
        btnSend.frame = btnSendRectWithKeyboard;
    }
    
    func checkMessages(){
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        let url = NSURL(string: "http://ndrzhr.selfip.com:8080/MainServlet");
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        
        let dictionary : [String:AnyObject] = [
            "action" : "getLocation",
            "userName" : "user",
            "fromMessage" : 9,
            "messageText":"Text Text",
            "lat":"\(lat)",
            "lng":"\(lng)",
            "time":"\(loc.timestamp)"
        ];
        var error:NSError?;
        let data = NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted, error: &error);
        let task = session.uploadTaskWithRequest(request, fromData: data);
        task.resume();

    }
    func handleSend(sender: UIButton){
        sendMessage();
        hideKeyboard();
        textField?.resignFirstResponder();
    }
    
    func sendMessage(){
        isCheckingForMessages = true;
        if (!textField!.hasText()){
            return;
        }
        let message = Message(text: "\(textField!.text)", bySender: self.userName);
        
        let messageAsDictionary: [NSString : AnyObject] = [
            "action": "send",
            "userName": message.sender,
            "messageText": message.messageText
        ];
        var jsonError: NSError?;
        let messageAsJson = NSJSONSerialization.dataWithJSONObject(messageAsDictionary, options: NSJSONWritingOptions.PrettyPrinted, error: &jsonError);
        if jsonError != nil{
            return;
        }
        
        
        //let dataToUpload = message.messageText.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        
        
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        let task = session.uploadTaskWithRequest(request, fromData: messageAsJson);
        task.resume();
        appendMessage(message);
        textField?.text = "";
    }
    func appendMessage(message: Message){
        data.append(message);
        let indexPathOfNewRow = NSIndexPath(forRow: data.count - 1, inSection: 0);
        tableView.insertRowsAtIndexPaths([indexPathOfNewRow], withRowAnimation: UITableViewRowAnimation.Automatic);
        //tableView.scrollToRowAtIndexPath(indexPathOfNewRow, atScrollPosition: UITableViewScrollPosition.Top, animated: true);
    }
    func hideKeyboard(){
        println("keyboard did hide");
        
        tableView.frame = tableViewRect;
        textField?.frame = textFieldRect;
        btnSend.frame = btnSendRect;
    }



}

