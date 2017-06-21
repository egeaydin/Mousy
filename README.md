# MousY
*Turn your phone to a magic wand*

## Brief Summary
This project is all about creating an air representer app which will allow users to move the mouse on the screen using their iPhones. Ideally they will also be able to use arrow keys, space keys and other keys that iPhones have. By this way, users are going to have a lot of control on their PC or Mac's. Instead of moving their phones like in the initial plan, they are going to rotate their phones which is going to move the mouse. 

## How to run?  
* First make sure bluetooth is turned on both in your Mac and iPhone.
* Plug your iPhone to your mac
* Download the source code 
* Go the `mousy` folder and run the `MousY.xcworkspce`, *there are other `.xproj` files, don't run them.*.  
* Notice the app label next to the stop button!   
![Screen Shot 2017-06-17 at 8.44.42 PM.png](https://bitbucket.org/repo/9p8MEoj/images/4238907715-Screen%20Shot%202017-06-17%20at%208.44.42%20PM.png) or ![Screen Shot 2017-06-17 at 8.45.28 PM.png](https://bitbucket.org/repo/9p8MEoj/images/2718577939-Screen%20Shot%202017-06-17%20at%208.45.28%20PM.png)  
* If you click the app level you will notice you can go between apps  
![Screen Shot 2017-06-17 at 8.43.47 PM.png](https://bitbucket.org/repo/9p8MEoj/images/1143943264-Screen%20Shot%202017-06-17%20at%208.43.47%20PM.png)
* First pick `MousyMacApp` and run it using play button
* Second pick `MousyiOSApp` and run it using play button

If all goes well, your iPhone screen should be saying **App Found** on the screen. If that's the case press the button that says start and:

* Press `Move Mouse` button and rotate your phone to see the behavior of the mouse cursor, press again to stop. While doing so try to left click somewhere.
* Watch the console on the Xcode. Make sure you are seeing the mac app console by the following:  
	* Notice the app label in the debug area  
![Screen Shot 2017-06-17 at 8.51.04 PM.png](https://bitbucket.org/repo/9p8MEoj/images/1641456974-Screen%20Shot%202017-06-17%20at%208.51.04%20PM.png)  
	* If it's saying `MousyMacApp` you are on the mac app console. Otherwise change it by clicking on it.  
![Screen Shot 2017-06-17 at 8.51.16 PM.png](https://bitbucket.org/repo/9p8MEoj/images/2053584983-Screen%20Shot%202017-06-17%20at%208.51.16%20PM.png)

## Version History  
* Commits [2021f7c](https://bitbucket.org/egeaydin/mousy/commits/2021f7c8b8057fc0bc4c586d1c064b65e9021dac) - [9490e4d](https://bitbucket.org/egeaydin/mousy/commits/9490e4d813a47587c20c86349f4c6d92d2ca5a4a)
    * Left click is working
    * Now the mouse movement can be started and stoped
* Commit [f7e67b4](https://bitbucket.org/egeaydin/mousy/commits/f7e67b401c98a201a70e55511c4cbc2807c6c992)
    * Now the rotation data moves the mouse cursor
* Commits between: [facbd90](https://bitbucket.org/egeaydin/mousy/commits/facbd90814f223dd27cfe26042a0a2e79dcded49) - [f8ddd04](https://bitbucket.org/egeaydin/mousy/commits/f8ddd04f8a1185a4319b879863c608f59ea216d5)
    * Merged two app into the same workspace
    * Converted to mac app to a game app in order to take advantages of vectors 
* Commit: [88f3184](https://bitbucket.org/egeaydin/mousy/commits/88f31848ee4c600cd662ad03a4ed97fe9e6c25a4)  
    * A big ugly button added to mac app for testing purposes, the button moves with the iPhone connected  
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
* Commit [f7e67b4](https://bitbucket.org/egeaydin/mousy/commits/f7e67b401c98a201a70e55511c4cbc2807c6c992)
    * The movement of mouse cursor is not that great
    * ~~You have to `Cmd + Q` to close the MacApp in order to get back the control of the mouse :joy:~~
* Commit: [c9f2141](https://bitbucket.org/egeaydin/mousy/commits/c9f214105e3813b0d8e998d2d57a02bb319ae170?at=master), [38b60e0](https://bitbucket.org/egeaydin/mousy/commits/38b60e00d680682f25e85b6bb026d279ff52c15a?at=master),
 [140bab5](https://bitbucket.org/egeaydin/mousy/commits/140bab597cb07b32b54b05e22b62677a9059d396?at=master):
    * Sometimes the iOS app cannot see the mac app, or problems when connecting might be encountered. If that happens please stop the both apps and run the mac app first, then run the iOS app. Which hopefully will fix the connection problem. :relieved:

## Eager to help?
Even small advices and suggestions are appreciated. Currently everything seems to be going smoothly.