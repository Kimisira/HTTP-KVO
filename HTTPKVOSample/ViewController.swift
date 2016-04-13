//
//  ViewController.swift
//  HTTPKVOSample
//
//  Created by Kimisira on 2016/04/13.
//  Copyright © 2016年 Kimisira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func respondToButton(sender: AnyObject) {
        //通信ボタン
        let queue = NSOperationQueue()
        let ope = HttpOperation(url:NSURL(string: "http://www.apple.com")!)
        queue.addOperation(ope)
        
        //KVO HttpOperationオブジェクトのfinishedプロパティの監視を開始する
        ope.addObserver(self, forKeyPath: "finished", options: .New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let ope = object as! HttpOperation
        let responseString:String = NSString(data:ope.responseData,encoding:NSUTF8StringEncoding) as! String
        print(responseString)
        object?.removeObserver(self,forKeyPath: keyPath!)
    }

}

