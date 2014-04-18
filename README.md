antiunflodd
===========

A daemon that waits for the Unflod.dylib file to be added and then removes it.

**Detailed Description**

The launchd plist starts the daemon called antiunflodd when the file */Library/MobileSubstrate/DynamicLibraries/Unflod.dylib* is created. (By setting the WatchPaths key in the launchd plist). The daemon then checks again if the file exists (which should always be the case) and then removes it and kills itself so it does not take further ressources.

**Unflod.dylib**

Read more about Unflod.dylib here:

[sektioneins.de - iOS Malware Campaign "Unflod Baby Panda"](https://www.sektioneins.de/en/blog/14-04-18-iOS-malware-campaign-unflod-baby-panda.html)

**Compile**

'''
make package
'''

Wasn't that hard, was it? :P
