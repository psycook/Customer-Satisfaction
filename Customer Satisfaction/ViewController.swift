//
//  ViewController.swift
//  Customer Satisfaction
//
//  Created by Simon Cook on 05/08/2016.
//  Copyright © 2016 Salesforce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var quiteHappyButotn: UIButton!
    @IBOutlet weak var quiteSadButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func happyButtonTouched(sender: AnyObject) {
        print("sending happy face")

        let json = ["MachineId":"Terminal - Security South", "Satisfaction":5];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func quiteHappyButtonTouched(sender: AnyObject) {
        print("sending quite happy face")

        let json = ["MachineId":"Terminal - Security South", "Satisfaction":4];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func quiteSadButtonTouhed(sender: AnyObject) {
        print("sending quite sad face")

        let json = ["MachineId":"Terminal - Security South", "Satisfaction":2];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func sadButtonTouched(sender: AnyObject) {
        print("sending sad")

        let json = ["MachineId":"Terminal - Security South", "Satisfaction":1];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    func sendRequest(payload: NSData) {
        //let request = NSMutableURLRequest(URL: NSURL(string: "https://thunder-gateway.herokuapp.com")!)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://smc-airport-test.herokuapp.com/csat")!)

        request.HTTPMethod = "POST"
        request.HTTPBody = payload

        [request .addValue("application/json", forHTTPHeaderField: "Content-Type")];


        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }

            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }

            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}
