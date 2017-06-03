# Mousy
*Turn your phone to a magic wand*

## Brief Summary
All IPhone and IPad devices have a device called accelerometer inside them. This accelerometer measures the acceleration of the three dimensions. This project is trying to calculate position changes of the device in order to create a real life like mouse, ultimately a magic wand that can be used in air. 
Note that this acceleration problem is not like the ones that we had in physics class. The data is noisy and the calculus is hard. 
More info on accelerometer's can be found [here](https://en.wikipedia.org/wiki/Accelerometer).

## Challenges
1. **Display**: IOS.Charts giving me hard time. It is hard to show realtime data on IOS.
2. **Noise Cancelation:** The data is noisy and needs filtering. Currently trying **"moving average"** technique.
3. **Zero Movement:** Even the IPhone stays still, the accelerometer still reads small accelerations. 
4. **Integration to position:** No idea how to take integral :sweat_smile:  
*None of the challenge are fully solved at the moment.*

## How to run?
After downloading the source code; please open the project from **"MousY.xcworkspce"** not**"MousY.xcodepoj"**. Plug your Iphone or Ipad.  
- You will see a white screen since nothing is working

## What is working?
*Nothing at the moment*

## Current Task
Display the X acceleration and so called filtered data on two separate graphs

##Finished Tasks
*None*

## Known problems
-Cannot seem to be able properly display realtime data on the screen. 
-Bunch of annoying cocoapods warnings 

## Eager to help?
Read the challenges again. :smiley: Even small tips and suggestions are appreciated.