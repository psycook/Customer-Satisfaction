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
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    var locationList: [String] = ["Parking Experience", "Check in Experience", "Security Experience", "Shopping Experience", "Boarding Experience"]
    var locationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationIndex = 0
        locationLabel.text = locationList[locationIndex]
        thanksLabel.hidden = true

        //set up a gesture handler on the locationLabel
        locationLabel.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.locationLabelTapped))
        locationLabel.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func happyButtonTouched(sender: AnyObject) {
        print("sending happy face")
        showThanks("Very Happy - Thanks")
        let json = ["MachineId":"" + locationList[locationIndex], "Satisfaction":5];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func quiteHappyButtonTouched(sender: AnyObject) {
        print("sending quite happy face")
        showThanks("Quite Happy - Thanks")
        let json = ["MachineId":"" + locationList[locationIndex], "Satisfaction":4];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func quiteSadButtonTouhed(sender: AnyObject) {
        print("sending quite sad face")
        showThanks("Quite Sad - Sorry")
        let json = ["MachineId":"" + locationList[locationIndex], "Satisfaction":2];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    @IBAction func sadButtonTouched(sender: AnyObject) {
        print("sending sad")
        showThanks("Very Sad - Sorry")
        let json = ["MachineId":"" + locationList[locationIndex], "Satisfaction":1];
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        sendRequest(jsonData)
    }

    func sendRequest(payload: NSData) {
        //let request = NSMutableURLRequest(URL: NSURL(string: "https://thunder-gateway.herokuapp.com")!)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://smc-airport-test.herokuapp.com/csat")!)

        request.HTTPMethod = "POST"
        request.HTTPBody = payload
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
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
    
    func showThanks(text: String) {
        thanksLabel.text = text
        thanksLabel.alpha = 1
        thanksLabel.hidden = false
        var _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.hideThanks), userInfo: nil, repeats: false)
    }
    
    func hideThanks() {
        UIView.animateWithDuration(1.0, animations: {
            self.thanksLabel.alpha = 0
            }, completion: {
                (value: Bool) in
                self.thanksLabel.hidden = true
                self.thanksLabel.text = "Thanks"
        })
    }
    
    func locationLabelTapped(gestureRecognizer: UIGestureRecognizer) {
        locationIndex += 1;
        if(locationIndex >= locationList.count) {
            locationIndex = 0;
        }
        locationLabel.text = locationList[locationIndex];
    }
}
