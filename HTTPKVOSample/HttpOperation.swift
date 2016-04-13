//
//  HttpOperation.swift
//  HTTPKVOSample
//
//  Created by Kimisira on 2016/04/13.
//  Copyright © 2016年 Kimisira. All rights reserved.
//

import Foundation

class HttpOperation: NSOperation,NSURLConnectionDataDelegate {
    
    //連絡先のURL
    private let url:NSURL
    
    //通信結果を保存する
    var responseData = NSMutableData()
    
    init(url:NSURL) {
        self.url = url
    }
    
    //通信結果を受け渡すために３つのメソッドを追加
    override var executing: Bool{
        get{ return _executing }
        set(newValue){
            willChangeValueForKey("executing")
            _executing = newValue
            didChangeValueForKey("executing")
        }
    }
    private var _executing = false
    
    override var finished: Bool{
        get{ return _finished }
        set(newValue){
            willChangeValueForKey("finished")
            _finished = newValue
            didChangeValueForKey("finished")
        }
    }
    private var _finished = false

    override var asynchronous: Bool{
        get{
            return true
        }
    }
    
    override func start() {
        //処置中
        self.executing = true
        
        //URL Requesutの生成
        let request = NSURLRequest(URL:self.url)
        
        //コネクションの生成
        let conn = NSURLConnection(request: request,delegate: self)
        
        //処理が実行されている間RunLoopを進める
        repeat{
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceReferenceDate:0.1))
        }
        while(self.executing)
    }
    
    //通信結果の受け取り
    func connection(connection:NSURLConnection,didReceiveData data:NSData){
        //通信結果を受け取る
        self.responseData.appendData(data)
    }
    //受け取りの終了
    func connectionDidFinishLoading(connection: NSURLConnection) {
        //実行中のフラグを解除
        self.executing = false
        
        //処理終了
        self.finished = true
    }
}