# MousY
*Turn your phone to a magic wand*

## Brief Summary
This project is all about creating an air representer app which will allow users to move the mouse on the screen using their iPhones. Ideally they will also be able to use arrow keys, space keys and other keys that iPhones have. By this way, users are going to have a lot of control on their PC or Mac's. Instead of moving their phones like in the initial plan, they are going to rotate their phones which is going to move the mouse. 

## How to run?  
* First make sure bluetooth is turned on both in your Mac and iPhone.
* Plug your iPhone to your mac
* Download the source code 
* Go the `MousyMacApp` folder and run the `MousyMacApp.xcodeproj` file. When Xcode loads just press run and let the app open. 
* Go the `MousyIOSApp` folder and run the `MousY.xcworkspce` not `MousY.xcodepoj`.

If all goes well, your iPhone screen should be saying **App Found** on the screen. If that's the case press the button and watch the console on the Xcode, the one that you opened for `MousyMacApp`. 

## Version History  
* Commit: [f8ee865](https://bitbucket.org/egeaydin/mousy/commits/f8ee8657a750735d00cfd897f05104611dd246ba)  
    * Created a class called XYZ to hold three axis values. This class is shared between both iOS and the mac app
    * The app now reads the rotation rate values from device motion and sends it to the mac app
    * The button on the screen starts the transmission now 
* This point is considered as a fresh start for this project. Commit: [c9f2141](https://bitbucket.org/egeaydin/mousy/commits/c9f214105e3813b0d8e998d2d57a02bb319ae170?at=master), [38b60e0](https://bitbucket.org/egeaydin/mousy/commits/38b60e00d680682f25e85b6bb026d279ff52c15a?at=master),
 [140bab5](https://bitbucket.org/egeaydin/mousy/commits/140bab597cb07b32b54b05e22b62677a9059d396?at=master):
    * Created the new Mac App
    * Bluetooth added to both mac and iOS app
    * Mac app acts as a peripheral device and iOS app can send messages to it
    * Uninstalled the charts package, which was not necessary anymore because of the new approach
    * Got rid of the old ViewController, there was nothing special about it.
* Including commit [5738a8a](https://bitbucket.org/egeaydin/mousy/commits/5738a8a25090fdad623ca23a85404e8418968d0e?at=master) and before this project was trying a different approach.

## Known problems
* Sometimes the iOS app cannot see the mac app, or problems when connecting might be encountered. If that happens please stop the both apps and run the mac app first, then run the iOS app. Which hopefully will fix the connection problem. :relieved:

## Eager to help?
Even small advices and suggestions are appreciated. Currently everything seems to be going smoothly.