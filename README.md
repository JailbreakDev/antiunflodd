antiunflodd
===========

A daemon that waits for the Unflod.dylib file to be added and then removes it.

**The Daemon**

The launchd plist starts the daemon called antiunflodd *(By setting the WatchPaths key in the launchd plist)* when the files

- /Library/MobileSubstrate/DynamicLibraries/Unflod.dylib
- /Library/MobileSubstrate/DynamicLibraries/framework.dylib

are created. The daemon then checks again if the file exists (which should always be the case) and then removes it and kills itself so it does not take further resources.

**The Tweak**

The Tweak hooks into any process and hooks the c function *connect()* it checks if the function wants to connect to one of the malicious IP Addresses. If that is the case, the tweak changes the ip to 127.0.0.1 which is localhost, so it will not leave the device.
Alternatively -1 can be returned for the connect call.

**About the dylib**

Read more about Unflod.dylib/framework.dylib here:

[sektioneins.de - iOS Malware Campaign "Unflod Baby Panda"](https://www.sektioneins.de/en/blog/14-04-18-iOS-malware-campaign-unflod-baby-panda.html)

**Compile**

```
make package
```

Wasn't that hard, was it? :P
