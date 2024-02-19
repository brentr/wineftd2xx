This is a Linux Wine dll.so that substitutes for FTDI's D2XX version 1 drivers.
It is effectively a shim layer between the FTDI's Linux D2XX drivers and 
Microsoft Windows applicatons running under Wine.
Almost all calls are emulated, except those that have no meaning under Unix.

FTDI's D2xx version 2 drivers are not supported.
Unfortunately, most recent software requires FTDI's version 2 libraries.

Note that wine version >= 7.0 is recommended.
The wine*-dev package is required to compile this shim library

To install, after cloning this repository locally:

1)  confirm that you have a functioning wine version >= 7.0
    You must configure it such that the desired wine executable and tools are 
    in your $PATH.

2)  at the top level directory of the repository, type:

  $  make 
  
    This will fetch the required libraries from FTDI's website and build 
    ftd2xx.dll.so and libftd2xx.def
    
3)  To add these files in your wine installation:

  $  sudo   make  install
  
 
4)  Ensure that your users have permission to access to the USB FTDI devices.
    If you use udev, this will likely involve adding rules in /etc/udev/rules.d
    
    For example, the Intronix LogicPort might be made accessible to all users
    in the plugdev group by:
    
    # sudo  cp  etc/udev/rules.d/81-logicport.rules  /etc/udev/rules.d

    Use 81-logicport.rules as a template if you have a different device.

   
5)  ftd2xx.dll.so requires that the FTDID variable be set to indicate the 
    USB Vendor and Product ID of the FTD2xx device your Windows application
    controls.  The syntax of the FTDID variable is either:
    
    FTDID=<USB Product ID>
    
    or:
    
    FTDID=<USB Vendor ID>:<USB Product ID>
    
    Product and Vendor ID are in hexidecimal.
    If omitted, the Vendor is assumed to be 0403 (hex).
    
    For example, 
      to start the windows application controlling Intronix LogicPort:
    
    $ FTDID=DC48 wine ~/.wine/drive_c/Program\ Files/LogicPort/LogicPort.exe 

The only issue I see with LogicPort.exe running under Wine is that the
command shortcut buttons do not render until one hovers the cursor over them.
Thus, at most one is visible at any time.
This is not really much of an issue, as the buttons do work when clicked and
all their functions are also available on dropdown menus.
    
**IMPORTANT**:  If running on a X68_64 system, only the 64-bit version of the library will be generated.
    The 64-bit library will not be recognized by 32-bit Windows applications!
    To generate the 32-bit library for use with 32-bit Windows apps:
    
    make clean   #remove the 64-bit objects
    make ARCH=i386   #build the 32-bit library
    sudo make ARCH=i386 install   #install the 32-bit library

Note:  Compiling this may require installing the gcc-multilib package
