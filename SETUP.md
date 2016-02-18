#Setting up your system

Original, up-to-date instructions can be found (in Finnish) [here](https://kirjoitusalusta.fi/hacklab-x-digi-xilinx-ise)

##Creating Xilinx user account
  - Go to [Xilinx site](http://www.xilinx.com/)
  - Create new user account if you don't have one -> Sign in
  - Down-right corner -> Create Account

Fill the information at your own conscience, Xilinx is obviously more interested in professionals than hobbyists, but every email address has been accepted so far. 

You will receive account activation link to your email.

Go again to Xilinx [main page](http://www.xilinx.com/)

Sign in with your account -> Sign in

Go to address [http://www.xilinx.com/getlicense](http://www.xilinx.com/getlicense) -> Verify your information -> next

-> Product Licensing -> Create New License -> Certificate Based Licenses

-> [X] ISE WebPACK License -> Generate Node-Locked License -> ... -> Next

On left down corner of page is a small down-arrow icon, click it to download a license file (Xilinx.lic).

## Installing ISE WebPACK development environment

Although Ubuntu is not officially supported, the software has been successfully installed on 64-bit Ubuntu versions 14.10 and 15.10 as well as on Debian Wheezy.

Download the installer from Downloads -> ISE Design Tools -> 14.7

If you wish to bypass the use of the Xilinx download manager, please see AR# 5784 -> http://www.xilinx.com/support/answers/57840.html

    -> ISE Design Suite - 14.7 Full Product Installation for Linux (TAR/GZIP - 6.09 GB)

Unpack the file with command 

    tar -xvf Xilinx_ISE_DS_Lin_14.7_1015_1.tar


Installation takes up 14 GB and will take a while.

Go to unpacked folder: 

    cd Xilinx_ISE_DS_Lin_14.7_1015_1/


Install

    sudo ./xsetup


    -> Next -> [X] [X] -> Next -> [X] -> Next -> ISE WebPACK -> Next

The default settings are fine, do not install the cable driver yet. 
    -> [ ] [X] [x] [ ]

Uncheck the first checkbox if you have already downloaded the license file.

Default folder "/opt/Xilinx" is fine -> Next -> Install

Go brew some coffee & check your emails, this will take a while.

Start-up:

Copy the license to its place in user's home folder under .Xilinx, for example: 

    mkdir ~/.Xilinx
    cp ~/Downloads/Xilinx.lic ~/.Xilinx/Xilinx.lic

Start ISE:

    source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise

Gnome based desktops can have .desktop file:

    nano xilinx-ise.desktop
    
    [Desktop Entry]
    Version=1.0
    Name=Xilinx ISE
    Type=Application
    Terminal=false
    Icon=/opt/Xilinx/14.7/ISE_DS/ISE/data/images/pn-ise.png
    Exec=bash -c "source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise"
    Categories=Utility;Application;Development;

    sudo desktop-file-install --delete-original xilinx-ise.desktop
    
Now you can find ISE like other programs, for example by writing 'ISE' in ubuntu "start menu" and you can attach id to side pane 'Lock to Launcher'

If you didn't copy the license on it's place, license manager will ask for the license:

     -> Ok -> Locate Excisting License(s) -> Next -> Load License...

Choose the Xilinx.lic file you downloaded earlier -> Ok -> Close


## Installing Platform Cable USB model DLC9G or DLC9LP programmer drivers

Connect the programmer with USB-cable to machine and list USB devices:

    lsusb

    Bus 003 Device 006: ID 03fd:0007 Xilinx, Inc. (tai :000F DLC9LP:llä)

Status led should be dim red. Disconnect the cable and run commands:

    sudo apt-get install libusb-dev fxload
    sudo nano /etc/udev/rules.d/xusbdfwu.rules

Add these two lines to file:

    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666"

    SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0007", RUN+="/sbin/fxload -v -t fx2 -I /usr/share/xusbdfwu.hex -D $tempnode"

    SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000f", RUN+="/sbin/fxload -v -t fx2 -I /usr/share/xusb_xlp.hex -D $tempnode"

Run

    sudo cp /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/*.hex /usr/share/
    sudo /etc/init.d/udev restart

You can also try your luck with "sudo udevadm control --reload-rules" instead of udev restart.
Reconnect USB, list devices again.

    lsusb

    Bus 003 Device 010: ID 03fd:0008 Xilinx, Inc.

Status LED is now bright red and will turn green if you connect the programmer to a powered CPLD board.


## Installing Xilinx ISE WebPACK -development environment on Windows 7 (8.1 at your own peril)

Download the Windows ISE [here](https://secure.xilinx.com/webreg/register.do?group=dlc&htmlfile=&emailFile=&cancellink=&eFrom=&eSubject=&version=14.7&akdm=0&filename=Xilinx_ISE_DS_Win_14.7_1015_1.tar)
The file is over 6GB so this will take a while.

Extract the packet to a convenient directory, Downloads or similar. File format .tar is originally from UNIX-environment, but at least free (as in beer) 7-zip program can open it. Download and install 7-zip if necessary.

Installation starts with xsetup-program. Installation is trivial on Windows, answer "OK" to all. You need to accept some user licenses and conditions but that's it. Be sure to pick the WebPACK-edition.

Installation itself takes a while, so brew some coffee and read your emails. In the end you're asked if you'd like to install Jungo-driver, answer yes so your programmer will function. 

Once installation is ready, you're asked to execute "settings.bat" script before using program. After installation go to installation directory of program (C:\Xilinx by default) and open command window from pop-up menu you get by right clicking with shift pressed down  ("Open Command Window Here). Write script name and press enter, you're ready almost instantly when script is completed.

ISE requires license while in a similar way as with Ubuntu, please see instructions above. Please note Windows 8.1 has issues with license manager. There are workarounds [here](https://www.youtube.com/watch?v=ttPbEcNjdo8) and [here](http://binarykoala.blogspot.fi/2013/10/get-xilinx-ise-146-webpack-to-work-on.html). Windows 8 is not officially supported at the time of writing, Please let us know if you succeed.

Afterwards you can start the Project Navigator from Start-menu. No special steps are required to install the programmer drivers assuming you installed the Jungo-driver before. LED is bright red when USB is connected and green when target device is connected.
