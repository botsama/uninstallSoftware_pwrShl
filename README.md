# uninstallSoftware_pwrShl
Search both Wow6432Node and WMI installer registry trees for removal of applications.

WMI uninstalls are easy and can be invoked without any user action.  Script will do the search and removal.

Wow6432Node will search relevant registry tree and return uninstaller string.  You would still need to use uninstaller UI to remove program but PowerShell script will return same value uninstall executable as would be ran, if you used add / remove programs to start uninstall process.

Warning for some WMI uninstallers such as Acronis software.  The WMI uninstaller will reboot once it completes.  Heeavily advised to test any and all applications you wish to uninstall on a Non-Production test environment.  I wrote these scripts testing against a Test domain lab built in a VirtualBox for any applications I was going to remove in Prod.
