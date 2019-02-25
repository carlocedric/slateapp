# slateapp
 Geofencing App

# Description
This app determines whether your device is within / outside a geofence area of the Main / Target Location.

# How to use
1. Upon launching the app, click **SET** to set your current location as the Main / Target Location.

  ![image](https://user-images.githubusercontent.com/12498448/53351392-30340200-395c-11e9-8ea9-6c898669bb19.png)

2. You can click **RESET** to change your Main / Target location. 
3. The app will then calculate the distance from your current location to the set / configured Main / Target Location.


# Legend

## INSIDE GEOFENCE IF: 
1. You are connected to a network / WIFI.

![image](https://user-images.githubusercontent.com/12498448/53351936-e4ce2380-395c-11e9-9f1e-a060a43b62cf.png)

Note:
Apple requires a paid Development Profile to be able to access WIFI name information - so for this app, I'm only checking whether the user is connected to a network or not.

![image](https://user-images.githubusercontent.com/12498448/53352337-91100a00-395d-11e9-925a-629dce412f33.png)

2. You are not connected to a network but is within **10 meters** from Main/Target location

![image](https://user-images.githubusercontent.com/12498448/53352588-02e85380-395e-11e9-94c9-6465e96a8257.png)

Note:
The max distance is configurable in the Constants file.

## OUTSIDE GEOFENCE IF: 

1. You are not connected to a network but is more than **10 meters** from Main/Target location

![image](https://user-images.githubusercontent.com/12498448/53352704-4478fe80-395e-11e9-9653-8fdd678b4652.png)








