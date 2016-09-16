# Cusomer Satisfaction iOS App
An app to give an end user four options to show their satisfaction with a service, in this case, the Airport security process.  This app is built using iOS and the swift programming language.  You will need OS X, xcode & and developer account if you want to deploy to a physical device.

# How to use
1.  Clone this git repository
2.  Open the project in xcode (OS X only sorry)
3.  Build the project
4.  Deploy to the Simulator or Device (developer account required)

# Files to Look at
The main action for this demo takes place in two files:
Main.storyboard - The UI for the demo
ViewController.swift - The controller for the UI (makes a webservice call based on which button is pressed)

# Customization
To brand the application change the images in the Assets.xcassets folder in the project.  Appicon contains the various sized icons required for the App and LaunchImage contains the various LaunchImage files.  The happy, mostly-happy, not-very-happy & sad images can also be replaced of course.  The text in the app can be changed in the 'Main.storyboard' file by selecting the 'Security Experience' UILabel.

The body of the webservice call is defined in the UIButton callback methods in the 'ViewController.swift' file (denoted by IBAction annotations).  These can be customised for your specific use case.

The webservice endpoint called by the application is defined in the 'ViewVController.swift' file in the 'sendRequest' function.  This endpoint can be changed to match your application requirements.  I have created a simple Heroku based REST endpoint (https://smc-airport-test.herokuapp.com/csat) that simply echos your request back and says thanks (it's nice to be polite).

# Next step
To include beacons in the demo enabling the story to be extended by allowing customers/employees to walk around an airport, store, factory, etc.  The beacons would allow the satisfaction feedback to be given for various locations.

# Feedback
Please provide feedback to simon.cook@salesforce.com
