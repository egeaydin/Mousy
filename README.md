# MousY
*Turn your phone to a magic wand*

## Brief Summary
This project is all about creating an air representer app which will allow users to move the mouse on the screen using their iPhones. Ideally they will also be able to use arrow keys, space keys and other keys that iPhones have. By this way, users are going to have a lot of control on their Windows or Mac machine. Instead of moving their phones like in the initial plan, they are going to rotate their phones which is going to move the mouse. 

## How to run?  
* First make sure bluetooth is turned on both in your Mac and iPhone.
* Plug your iPhone to your mac
* Download the source code 
* Go the `mousy` folder and run the `MousY.xcworkspce`, *there are other `.xproj` files, don't run them.*.  
* Notice the app label next to the stop button!   
![alt text][ss_app_label_1] or ![alt text][ss_app_label_2] 
* If you click the app label you will notice you can go between apps  
![alt text][ss_between_apps]
* First pick `MousyMacApp` and run it using play button
* Second pick `MousyiOSApp` and run it using play button

If all goes well, your iPhone screen should be saying **App Found** on the screen. If that's the case press the button that says start and:

* Press `Move Mouse` button and rotate your phone to see the behavior of the mouse cursor, press again to stop. While doing so try to left click somewhere.
* Watch the console on the Xcode. Make sure you are seeing the mac app console by the following:  
	* Notice the app label in the debug area  
![alt text][ss_debug_area]
	* If it's saying `MousyMacApp` you are on the mac app console. Otherwise change it by clicking on it.  
![alt text][ss_switch_apps]

## Version History  
* Commit [65ec3c6]
    * Added a slider to the IOS App that controls the tracking speed of the mouse cursor
* Commit [18071f1]
    * Right click is working
* Commits between: [2021f7c] - [9490e4d]
    * Left click is working
    * Now the mouse movement can be started and stoped
* Commit [f7e67b4]
    * Now the rotation data moves the mouse cursor
* Commits between: [facbd90] - [f8ddd04]
    * Merged two app into the same workspace
    * Converted to mac app to a game app in order to take advantages of vectors 
* Commit: [88f3184] 
    * A big ugly button added to mac app for testing purposes, the button moves with the iPhone connected  
* Commit: [f8ee865]  
    * Created a class called XYZ to hold three axis values. This class is shared between both iOS and the mac app
    * The app now reads the rotation rate values from device motion and sends it to the mac app
    * The button on the screen starts the transmission now 
* This point is considered as a fresh start for this project. Commit: [c9f2141], [38b60e0], [140bab5]:
    * Created the new Mac App
    * Bluetooth added to both mac and iOS app
    * Mac app acts as a peripheral device and iOS app can send messages to it
    * Uninstalled the charts package, which was not necessary anymore because of the new approach
    * Got rid of the old ViewController, there was nothing special about it.
* Including commit [5738a8a] and before this project was trying a different approach.

## Known problems
* Commit [18071f1]
    * If you try to click without `mouse move` active, the cursor goes to a weird location and clicks there
    * While using the `mouse move`, if you make a right click or open a dialog like a right click will open; all the functionality gets broken and mouse stops until that dialog closes. This point you need to close this dialog with your regular mouse or track pad. 
* Commit [f7e67b4]
    * The movement of mouse cursor is not that great
    * ~~You have to `Cmd + Q` to close the MacApp in order to get back the control of the mouse :joy:~~
* Commit: [c9f2141], [38b60e0], [140bab5]:
    * Sometimes the iOS app cannot see the mac app, or problems when connecting might be encountered. If that happens please stop the both apps and run the mac app first, then run the iOS app. Which hopefully will fix the connection problem. :relieved:

## Eager to help?
Even small advices and suggestions are appreciated. Currently everything seems to be going smoothly.

[ss_app_label_1]: github/ss_app_label_1.png "app label 1"
[ss_app_label_2]: github/ss_app_label_2.png "app label 2"
[ss_between_apps]: github/ss_between_apps.png "between apps"
[ss_debug_area]: github/ss_debug_area.png "debug area"
[ss_switch_apps]: github/ss_switch_apps.png "switch apps"

[65ec3c6]:https://github.com/egeaydin/Mousy/commit/65ec3c63f87e37d29740e33b2cead76293a98231
[18071f1]:https://github.com/egeaydin/Mousy/commit/18071f1280fe789d5f509351d4c166b4ce5b3f1f
[2021f7c]:https://github.com/egeaydin/Mousy/commit/2021f7c8b8057fc0bc4c586d1c064b65e9021dac
[9490e4d]:https://github.com/egeaydin/Mousy/commit/9490e4d813a47587c20c86349f4c6d92d2ca5a4a
[f7e67b4]:https://github.com/egeaydin/Mousy/commit/f7e67b401c98a201a70e55511c4cbc2807c6c992
[facbd90]:https://github.com/egeaydin/Mousy/commit/facbd90814f223dd27cfe26042a0a2e79dcded49
[f8ddd04]:https://github.com/egeaydin/Mousy/commit/f8ddd04f8a1185a4319b879863c608f59ea216d5
[88f3184]:https://github.com/egeaydin/Mousy/commit/88f31848ee4c600cd662ad03a4ed97fe9e6c25a4
[f8ee865]:https://github.com/egeaydin/Mousy/commit/f8ee8657a750735d00cfd897f05104611dd246ba
[c9f2141]:https://github.com/egeaydin/Mousy/commit/c9f214105e3813b0d8e998d2d57a02bb319ae170
[38b60e0]:https://github.com/egeaydin/Mousy/commit/38b60e00d680682f25e85b6bb026d279ff52c15a
[140bab5]:https://github.com/egeaydin/Mousy/commit/140bab597cb07b32b54b05e22b62677a9059d396
[5738a8a]:https://github.com/egeaydin/Mousy/commit/5738a8a25090fdad623ca23a85404e8418968d0e